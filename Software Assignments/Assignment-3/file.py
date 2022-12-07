
from queue import Queue
import copy

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

def get_all_prime_implicants(term):
    
    """
        term is binary_String
        dfs over legal_region from a term to all the largest enclosing regions (prime implicatns),
        returns optimal enclosing regions for each time step
        returns ( set_of_all_prime_implicants, size_of_prime_implicants)
        here size of prime_implicants is the number of literals in the implicant
    """
    global legal_regions
    
    best_ans = term
    # best_child = None
    ans = {term} ### set of prime implicants
    size_of_ans = number_of_non_none(term)

    for i, var in enumerate(term):
        if(var != "-"):
            candidate_expansion = term[0:i] + "-" + term[i+1:]
            if(candidate_expansion in legal_regions):
                possible_result = get_all_prime_implicants(candidate_expansion)
                if( possible_result[1] < size_of_ans):
                    ans = possible_result[0]
                    size_of_ans = possible_result[1]
                elif( possible_result[1] == size_of_ans):
                    ans = ans.union(possible_result[0])

                # if( number_of_non_none(possible_result) < number_of_non_none(best_ans)): 
                #     best_ans = possible_result
                #     best_child = candidate_expansion
    return (ans, size_of_ans)


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


    


def binary_string_to_decimal_string(bs):
    pow_of_2 = 1
    ans = 0
    for i in range(len(bs)-1,-1,-1):
        if(bs[i] == '1'):
            ans += pow_of_2
        pow_of_2 *= 2
    return str(ans)
# print(binary_string_to_decimal_string('10010'))

def findEssentialPrimeImplicants(chart):
    
    '''
        finds the essential prime implicant chart
    '''
    epi = []
    for minterm in chart:
        if( len(chart[minterm]) == 1):
            if( chart[minterm][0] not in epi):
                epi.append(chart[minterm][0])
    return epi

def implicant_to_min_terms(imp, idx=0):
    '''
        -1-0 => [0100, 0110, 1100, 1110]
    '''
    if( idx == len(imp)):
        return [imp] 
    
    if( imp[idx] == '-'):
        t1 = imp[0:idx] + '0' + imp[idx+1:]
        t2 = imp[0:idx] + '1' + imp[idx+1:]
        return implicant_to_min_terms( t1, idx+1) + implicant_to_min_terms( t2, idx+1)
    else:
        return implicant_to_min_terms(imp, idx+1)

# print(implicant_to_min_terms('-0-1'))
def removeEssentialPI(epi, chart, covering_implicants, deleted_implicants, ImplicantToTrueTerm):

    for term in epi:
        for j in implicant_to_min_terms(term):
            try:
                for implicant in chart[ binary_string_to_decimal_string(j) ]:
                    if( implicant in covering_implicants):
                        if( term not in covering_implicants[implicant]):
                            covering_implicants[implicant].append( term )
                    else:
                        covering_implicants[implicant] = [term]
                    ImplicantToTrueTerm[implicant].remove(binary_string_to_decimal_string(j))
                    if( len(ImplicantToTrueTerm[implicant]) == 0 and implicant != term ):
                        deleted_implicants[implicant] = True
                del chart[ binary_string_to_decimal_string(j)]
            except:
                pass 
    
    return


def mul(x,y): # Multiply 2 minterms
    # print( 'mul', x, y) [A,B,C] [B,C,D]
    res = []
    for i in x:
            res.append(i)
    for i in y:
        if i not in res:
            res.append(i)
    return res

def multiply(x,y): # Multiply 2 expressions [[A', B] , [ B,C ]], [[B', C] , [ A,C ]]
    res = []   
    for i in x:
        for j in y:
            tmp = mul(i,j)
            res.append(tmp) if len(tmp) != 0 else None
    return res


def opt_function_reduce(func_TRUE, func_DC):
    """
    determines the minimum number of sum of product terms for the given K-map function
    Arguments:
    func_TRUE: list containing the terms for which the output is '1'
    func_DC: list containing the terms for which the output is 'x'
    Return:
    a list of minimum size containing terms: terms in form of boolean literals
    """
    # your code here
    global legal_regions
    # your code here
    for term in func_DC:
        legal_regions[term_to_binary_string(term)] = True
    for term in func_TRUE:
        legal_regions[term_to_binary_string(term)] = True
    
    all_legal_regions(func_DC + func_TRUE, len(func_DC))
    
    # expansion_path = {} ### will store the expansion_path for each term/ pass by reference
    prime_implicant_chart = {}
    all_prime_implicants = set()
    for term in func_TRUE:
        set_of_prime_implicants, size_of_prime_implicants = get_all_prime_implicants(term_to_binary_string(term)) ### returns all the prime implicants for a term
        all_prime_implicants = all_prime_implicants.union(set_of_prime_implicants)
        list_of_prime_implicants = [binary_string_to_term(imp) for imp in set_of_prime_implicants]
        # print(term_to_binary_string(term), [ imp for imp in set_of_prime_implicants])
        prime_implicant_chart[ binary_string_to_decimal_string(term_to_binary_string(term))] = [ imp for imp in set_of_prime_implicants]
        # print(list_of_prime_implicants, size_of_prime_implicants)
        expansion_path = {}

    for pi in all_prime_implicants:
        for j in implicant_to_min_terms(pi):
            i = binary_string_to_decimal_string(j)
            if( i in prime_implicant_chart):
                if( pi not in prime_implicant_chart[i]):
                    # print("MC")
                    prime_implicant_chart[i].append(pi)
                    # print(i, pi )
    # print(prime_implicant_chart)
    covering_implicants = {}
    deleted_implicants = {}

    ImplicantToTrueTerm = {}
    for key in prime_implicant_chart:
        for implicant in prime_implicant_chart[key]:
            if( implicant not in ImplicantToTrueTerm):
                    ImplicantToTrueTerm[implicant] = [key]
            else:
                ImplicantToTrueTerm[implicant].append(key)    

    essential_prime_implicants = findEssentialPrimeImplicants(prime_implicant_chart)
    # print(essential_prime_implicants)
    removeEssentialPI(essential_prime_implicants, prime_implicant_chart, covering_implicants, deleted_implicants, ImplicantToTrueTerm)
    # print(prime_implicant_chart)
    if(len(prime_implicant_chart) == 0 ):
        ans = [binary_string_to_term(epi) for epi in essential_prime_implicants]
        # return ans
        final_result = ans
    else:
        ## O(logn) approximation to set cover
        # print(prime_implicant_chart)
        ImplicantToTrueTerm = {}
        for key in prime_implicant_chart:
            for implicant in prime_implicant_chart[key]:
                if( implicant not in ImplicantToTrueTerm):
                    ImplicantToTrueTerm[implicant] = [key]
                else:
                    ImplicantToTrueTerm[implicant].append(key)
        final_result = []
        while( len(ImplicantToTrueTerm) > 0 ):
            max_size = 0
            best_implicant = None
            for implicant in ImplicantToTrueTerm:
                if( len(ImplicantToTrueTerm[implicant]) > max_size ):
                    best_implicant = implicant
                    max_size = len(ImplicantToTrueTerm[implicant])
            
            final_result.append(best_implicant)
            terms_covered = copy.deepcopy(ImplicantToTrueTerm[best_implicant])
            deleted_keys = []
            for term in terms_covered:
                for key in ImplicantToTrueTerm:
                    if( term in ImplicantToTrueTerm[key]):
                        ImplicantToTrueTerm[key].remove(term)
                        # print("key", key, best_implicant)
                        if( key != best_implicant ):
                            if( key in covering_implicants):
                                    if( best_implicant not in covering_implicants[key]):
                                        covering_implicants[key].append(best_implicant)
                            else:
                                covering_implicants[key] = [best_implicant]
                        if(len(ImplicantToTrueTerm[key]) == 0):
                            deleted_keys.append(key)
            for key in deleted_keys:
                del ImplicantToTrueTerm[key]
                if( key != best_implicant ):
                    deleted_implicants[key] = True
            
        final_result.extend(essential_prime_implicants)
        final_result = [binary_string_to_term(i) for i in final_result]    
        # print(covering_implicants)

        ### removed regions for demo
        # for di in deleted_implicants:
        #     # print(di)
        #     print(f"Region not Considered {binary_string_to_term(di)}")
        #     print(f"Was covered by {[binary_string_to_term(x) for x in covering_implicants[di]]}")

        ## patricks's method (exponential but optimal)
        # print("Patrick's method")
        # P = [[ [j] for j in prime_implicant_chart[i]] for i in prime_implicant_chart]
        # while len(P)>1: # Keep multiplying until we get the SOP form of P
        #     P[1] = multiply(P[0],P[1])
        #     P.pop(0)
        # # print(P[0])
        # final_result = min(P[0],key=len) # Choosing the term with minimum variables from P
        # # print(final_result)
        # final_result.extend( essential_prime_implicants)
        # # final_result.extend(split_term_string(binary_string_to_term(i)) for i in essential_prime_implicants) # Adding the EPIs to final solution
        # final_result = [ binary_string_to_term(x) for x in final_result]
      
        
        
    legal_regions = {}
    return final_result
