import numpy as np

def match_pops(true, est):
    """
    Parameters
    ----------
        true : an N x K numpy array containing ground truth ancestry components.
        est  : an N x K numpy array contained estimate ancestry components. 
    
    Returns
    -------
        assignments : list of integer ids matching the columns of true
                      to the columns of est. Specifically,
                           assignments[i] = j
                      means that column i in true corresponds to column
                      j in est. The ground truth ancestry components can
                      be reordered by calling
                           true = true[:,assignments]
                      with the values returned from this function.

    """
    assert est.shape == true.shape
    npops = true.shape[1]
    distances = np.zeros((npops, npops))
    for id1, row1 in enumerate(true.T):
        for id2, row2 in enumerate(est.T):
            distances[id1, id2] = np.square(row1 - row2).sum()
    assignments = [i for i in range(npops)]
    for i in range(npops):
        label = np.unravel_index(np.nanargmin(distances), (npops, npops))
        distances[label[0]] = np.array([np.nan for i in range(npops)])
        distances[:,label[1]] = np.array([np.nan for i in range(npops)])
        assignments[label[1]] = label[0]
    return assignments