%% Removes elements that aren't wanted

IndexofElementstoRemove = find(IncludedElements == 0);

combinedfullelements(IndexofElementstoRemove,:) = [];
SparseElements(IndexofElementstoRemove,:) = [];
ElementNames(IndexofElementstoRemove,:) = [];
NormaliseElements(IndexofElementstoRemove,:) = [];
