from K_map_gui_tk import *

def log_to_base_2(x):
    pow = 0
    value = 1
    while( value != x ):
        value *= 2
        pow += 1
    return pow

def n_bit_gray_code(n):
    if(n==1):
        return ["0","1"]
    subproblem = n_bit_gray_code(n-1)
    ans = []
    for subproblem_answer in subproblem:
        ans.append("0" + subproblem_answer)
    subproblem.reverse()
    for subproblem_answer in subproblem:
        ans.append("1" + subproblem_answer)
    return ans
    
def dfs_for_legality( variable_index, term, total_variables, current_assignment, row_gray_code_to_idx, column_gray_code_to_idx, kmap_function):
    
    if(variable_index == total_variables):
        ### check for legality of current_assignment (terminal state)
        column_variables = (total_variables+1)//2
        column_gray_code = ""
        row_gray_code = ""
        for i in range(column_variables):
            column_gray_code += "1" if (current_assignment[i] == 1) else "0"
        for i in range(column_variables, total_variables):
            row_gray_code += "1" if (current_assignment[i] == 1) else "0"
        row_idx = row_gray_code_to_idx[row_gray_code]
        col_idx = column_gray_code_to_idx[column_gray_code]
        if( kmap_function[row_idx][col_idx] == 0 ):
            return False
        else:
            return True
        
        
    else:
        if(term[variable_index] is not None):
            current_assignment[variable_index] = term[variable_index]
            return dfs_for_legality(variable_index+1, term, total_variables, current_assignment, row_gray_code_to_idx, column_gray_code_to_idx, kmap_function)
        else:
            ### try both values
            current_assignment[variable_index] = 0
            is_legal = dfs_for_legality(variable_index+1, term, total_variables, current_assignment,  row_gray_code_to_idx, column_gray_code_to_idx, kmap_function)
            if( not is_legal ):
                return False
            current_assignment[variable_index] = 1
            is_legal = dfs_for_legality(variable_index+1, term, total_variables, current_assignment,  row_gray_code_to_idx, column_gray_code_to_idx, kmap_function)
            return is_legal
            
def one_term_helper(term1):
    l=0
    r=1
    if(term1 == 0):
        r = 0
    elif(term1 == 1):
        l = 1
    return l, r
    
def two_term_helper(term1, term2):
    l = 0
    r = 3
    if( term1 is None):
        if(term2 == 0):
            l,r = 3,0
        elif(term2 == 1):
            l,r = 1,2
    elif(term2 is None):
        if(term1 ==0):
            l,r = 0,1
        elif(term1==1):
            l,r = 2,3
    else:
        if(term1 == 0 and term2 == 0):
            l,r = 0,0
        elif( term1 == 0 and term2 == 1):
            l,r = 1,1
        elif(term1 == 1 and term2 == 1):
            l,r = 2,2
        elif(term1 == 1 and term2 == 0):
            l,r = 3,3
    
    return l, r
    
def is_legal_region(kmap_function, term):
    """
    determines whether the specified region is LEGAL for the K-map function
    Arguments:
    kmap_function: n * m list containing the kmap function
    for 2-input kmap this will 2*2
    3-input kmap this will 2*4
    4-input kmap this will 4*4
    term: a list of size k, where k is the number of inputs in function (2,3 or 4)
    (term[i] = 0 or 1 or None, corresponding to the i-th variable)
    Return:
    three-tuple: (top-left coordinate, bottom right coordinate, boolean value)
    each coordinate is represented as a 2-tuple
    """
    rows, columns = len(kmap_function), len(kmap_function[1])
    number_of_row_variables = log_to_base_2(rows)
    number_of_column_variables = log_to_base_2(columns)
    k = len(term)
    ### checking legal/illegal
    row_gray_code = n_bit_gray_code(number_of_row_variables)
    column_gray_code = n_bit_gray_code(number_of_column_variables)
    row_gray_code_to_idx = {}
    column_gray_code_to_idx = {}
    
    for i,gc in enumerate(row_gray_code):
        row_gray_code_to_idx[gc] = i
        
    for i, gc in enumerate(column_gray_code):
        column_gray_code_to_idx[gc] = i
        
    total_number_of_variables = number_of_column_variables + number_of_row_variables
    initial_assignment = [ None for i in range(total_number_of_variables)]
    is_legal = dfs_for_legality(0, term, total_number_of_variables, initial_assignment, row_gray_code_to_idx, column_gray_code_to_idx, kmap_function)
    
    ### finding co-ordinates
    tlx = 0
    tly = 0
    brx = rows-1
    bry = columns-1
    
    if(k == 2):
        tly, bry = one_term_helper(term[0])
        tlx, brx = one_term_helper(term[1])
    
    if( k == 3 ):
        
        tlx, brx = one_term_helper(term[2])
        tly, bry =  two_term_helper(term[0], term[1])
    
    if( k == 4):
        tlx, brx = two_term_helper(term[2], term[3])
        tly, bry = two_term_helper(term[0], term[1])

    
    return ((tlx, tly), (brx, bry) ,is_legal)
    
