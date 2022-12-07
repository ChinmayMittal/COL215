from queue import Queue


legal_regions = {} ### stores all legal_regions found during exploration

def split_term_string(term):
    """
        "abc'" => [ "a", "b", "c'" ] 
    """
    if(len(term) == 1):
        return [term]
    elif(len(term) == 2 and term[1] == "'"):
        return [term]
    else:
        if(term[1] == "'"):
            return [term[0:2]] + split_term_string(term[2:])
        else:
            return [term[0:1]] + split_term_string(term[1:])

def list_to_term(list_of_variables):
    """
        ["a'", "b", "c'" ] => "a'bc'" 
    """ 
    ans = ""      
    for var in list_of_variables:
        ans += var
    return ans

def complement_var(var):
    if(len(var) == 2):
        return var[0:1]
    else:
        return var + "'"

def term_to_binary_string(term):
    list_of_vars = split_term_string(term)
    binary_string = ""
    for var in list_of_vars:
        if(len(var) == 2):
            binary_string += "0"
        else:
            binary_string += "1"
    return binary_string

def binary_string_to_term(bs):
    term = ""
    for i,var in enumerate(bs):
        if(var == "0"):
            term += (chr(97+i)+"'")
        elif( var == "1"):
            term += (chr(97+i))
        else:
            ### skip variable for -
            pass
    return term

def complement_binary(b):
    if( b == "0"):
        return "1"
    elif( b == "1"):
        return "0"
    
def all_legal_regions(initial_regions, number_of_true_terms):
    """
        initial_regions is a list of terms as strings
    """
    global legal_regions ### stores strings
    bfs_queue = Queue() ### stores binary strings
    visited = {} ### stores strings
    
    for i,initial_region in enumerate(initial_regions):
        bfs_queue.put(term_to_binary_string(initial_region)) 

    while ( not bfs_queue.empty() ):
        current_region = bfs_queue.get() ## string representing the candidate region to be expanded
        if( current_region in visited):
            continue ### don't process a region twice
        else:
            visited[current_region] = True
            expansion_possible = False
            for i, var in enumerate(current_region): ### current_region is a binary string
                if(var != "-"):
                    complement_binary_string = current_region[0:i] + complement_binary(current_region[i]) + current_region[i+1:]
                    if( complement_binary_string in legal_regions):
                        expansion_possible = True
                        new_region = current_region[0:i]  + "-" + current_region[i+1:]
                        legal_regions[new_region] = True 
                        bfs_queue.put(new_region)
                    
            # if( not expansion_possible):
            #     terminal_nodes.append(binary_string_to_term(current_region))
    
    # for node in terminal_nodes:
    #     print(node)

def number_of_non_none(bs):
    cnt = 0
    for var in bs:
        if(var != "-"):
            cnt += 1
    return cnt
def dfs_from_term(term, expansion_path):
    
    """
        term is binary_String
        dfs over legal_region from a term to find the largest enclosing region,
        returns optimal enclosing region for each time step
    """
    global legal_regions
    
    
    best_ans = term
    best_child = None
    for i, var in enumerate(term):
        if(var != "-"):
            candidate_expansion = term[0:i] + "-" + term[i+1:]
            if(candidate_expansion in legal_regions):
                possible_result = dfs_from_term(candidate_expansion, expansion_path)
                if( number_of_non_none(possible_result) < number_of_non_none(best_ans)): 
                    best_ans = possible_result
                    best_child = candidate_expansion
    if( best_child is None):
        expansion_path[ binary_string_to_term(term)] = None
    else:
        expansion_path[ binary_string_to_term(term)] = binary_string_to_term(best_child)
    return best_ans            

def value_list_to_all_terms(value_list, i):
    if( i == len(value_list)):
        return [""]
    else:
        temp_ans = value_list_to_all_terms(value_list, i+1)
        if( value_list[i] == 0):
            return [chr(97+i) + "'" + t for t in temp_ans ] 
        elif( value_list[i] == 1):
            return [chr(97+i) + t for t in temp_ans ] 
        else:
            return [chr(97+i) + "'" + t for t in temp_ans ] + [chr (97+i) + t for t in temp_ans ]  

def expand_region( term, original_term):
    list_of_all_vars = split_term_string(original_term)
    list_of_fixed_vars = split_term_string(term)
    value_list = [ 0 for i in range(len(list_of_all_vars))]
    j = 0
    for i in range(len(list_of_all_vars)):
        if( j < len(list_of_fixed_vars) and list_of_all_vars[i][0] == list_of_fixed_vars[j][0] ):
            value_list[i] = 1 if (len(list_of_fixed_vars[j]) == 1) else 0
            j += 1
        else:
            value_list[i] = None
    return value_list_to_all_terms(value_list, 0)

def demoExpansionStack(term, expansion_path, original_term):
    if( term == original_term ):
        print(f"PRINTING EXPANSION TRACE FOR {original_term}")
    if(term is not None):
        print(f"\tCurrent term expansion: {term}")
        next_term = expansion_path[term]
        if(next_term is not None):
            expansion_region_list = []
            l1 = split_term_string(next_term)
            l2 = split_term_string(term)
            i = 0 
            while(i < len(l2)):
                if( i == len(l1) ):
                    expansion_region_list = l1 + [complement_var(l2[-1])]
                elif( l1[i][0] != l2[i][0]):
                    expansion_region_list = l2[:i] + [complement_var(l2[i])] + l2[i+1:]
                    break
                i += 1
            next_terms_for_expansion = expand_region(list_to_term(expansion_region_list), original_term)
            print("\t\tNext Legal Terms for Expansion: ", end = "")
            for t in next_terms_for_expansion:
                print(t, end = " ")
            print()
        demoExpansionStack(expansion_path[term], expansion_path, original_term)  
    else:
        print("\tEXPANSION TERMINATED")
        return
        

def comb_function_expansion(func_TRUE, func_DC):
    """
    determines the maximum legal region for each term in the K-map function
    Arguments:
    func_TRUE: list containing the terms for which the output is '1'
    func_DC: list containing the terms for which the output is 'x'
    Return:
    a list of terms: expanded terms in form of boolean literals
    """
    global legal_regions
    # your code here
    for term in func_DC:
        legal_regions[term_to_binary_string(term)] = True
    for term in func_TRUE:
        legal_regions[term_to_binary_string(term)] = True
    
    all_legal_regions(func_DC + func_TRUE, len(func_DC))
    
    ans = []
    expansion_path = {} ### will store the expansion_path for each term/ pass by reference
    for term in func_TRUE:
        ans.append( binary_string_to_term(dfs_from_term(term_to_binary_string(term), expansion_path)))
        demoExpansionStack(term, expansion_path, term)
        print("X"*100)
        expansion_path = {}
    legal_regions = {}
    return ans

funcc_TRUE = ["a'bc'd'", "abc'd'", "a'b'c'd", "a'bc'd", "a'b'cd"]
funcc_DC = ["abc'd", "ab'c'd", "ab'c'd'", "a'b'c'd'"]

out = comb_function_expansion(funcc_TRUE, funcc_DC)
print(out)
