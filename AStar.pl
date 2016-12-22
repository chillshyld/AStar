
%%--Version1
%% initialise()
%% 	heap.push(startnode,value)


%% do {
%% 	current = heap.pop
%% 	for node in current's neigbor
%% 		add node to heap

%% 	}
%% 	while (current is not destination and heap not emptied)




%%--Version2
%% initialise()
%% 	heap.push(startnode,value)
%% 	visited = empty list

%% do {
%% 	current = heap.pop
%% 	push current into visted list
%% 	for node in current's neigbor
%% 		add node to heap()

%% 	}
%% 	while (current is not destination and heap not emptied)


%% add node to heap()
%% 	if node is already visited
%% 		don't add into heap
%% 	else
%% 		calculate f cost for the neigbor node
%% 		if node is already in to be visited
%% 			update its g value 
%% 			update its parent
%% 		else
%% 			add to heap


%% add node to heap()
%% 	if node is already visited
%% 		don't add into heap
%% 	else
%% 		calculate the g cost of neibor node 
%% 		if node is already in to be visited
%% 			if its g is less than what is inside the visited node
%% 				remove the node from to be visited list
%% 			else 
%% 				do nothing
		
%% 		calculate f cost
%%		set parent to the node
%% 		add to heap


%% a_star(Start,Destination,Path):-
%% 	add_to_heap(heap(nil,0),0,Start,InitHeap),
%% 	assert(parent_of(x,x)),
%% 	search(x,Destination, heap(t((3, 0), 3, [t((4, 0), 4, [t((5, 0), 5, []), t((3, 1), 6, [t((..., ...), 6, [])])])]), 5),[],TempPath),
%% 	removeAtIndex(TempPath,0,Path).


%% %% if current node is the same as destination node
%% search(Current,Destination,OpenList,ClosedList,Path):-
%% 	%%Check if current node matched with the destination, if yes return true and terminate
%% 	Current == Destination,
%% 	parent_of(Destination,Parent),
%% 	append([Parent],[Destination],Path),
%% 	!.

%% search(Current,Destination,OpenList,ClosedList,ResPath):-
%% 	%%Get node with the least value from heap
%% 	get_from_heap(OpenList,Value,ResCurrent,ResOpenList),
%% 	%%Setting parent to current node
%% 	assert(parent_of(ResCurrent,Current)),
%% 	search(ResCurrent,Destination,ResOpenList,ClosedList,[H|T]),
%% 	parent_of(H,X),
%% 	append([X],[H|T],ResPath).
	







removeAtIndex([_|T],0,T).
removeAtIndex([H|T],Index,[H|Res]):-
	Index > -1,
	Counter is Index - 1,
	removeAtIndex(T,Counter,Res).



search(Current,Destination,OpenList,Path):-
	Current == Destination,
	append([],[Destination],Path),
	!.


search(Current,Destination,OpenList,Path):-
	%% add to open list

	%%pop node with least value from heap
	get_from_heap(OpenList,Value,NextNode,ResOpenList),
	%%Temp
	assert(parent_of(NextNode,Current)),
	search(NextNode,Destination,ResOpenList,[H|T]),
	parent_of(H,Parent),
	append([Parent],[H|T],Path).


	














