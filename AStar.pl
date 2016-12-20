
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


a_star(Start,Destination,Path):-
	add_to_heap(heap(nil,0),0,Start,InitHeap),
	search(x,Destination,InitHeap,[],Path).


%% if current node is the same as destination node
search(Current,Destination,OpenList,ClosedList,Path):-
	Current == Destination,!.

search(Current,Destination,OpenList,ClosedList,Path):-
	get_from_heap(OpenList,Value,ResCurrent,ResOpenList),
	search(ResCurrent,Destination,ResOpenList,ClosedList,Path).


























