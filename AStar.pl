
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
%% 	calculate node's g cost 
%% 	if node is in already visited list
%% 		if node g cost is < alredy in visited node's g cost
%% 			remove that node from the already visited list
%% 		else
%% 			do nothing
%% 	else
%% 		do nothing
%% 	if node is in to be visited list
%% 		if node's g cost is < in to be visited list node's g cost
%% 			remove that node from the to be visited list
%% 		else
%% 			do nothing
%% 	else
%% 		do nothing
%% 	if node is not in to be visited list and already visited list
%% 		calculate h cost
%% 		calculate total f cost
%% 		add the node to open list

%% add node to heap()
%% 	calculate node's g cost
%% 	check wa yoo nai closed list mai
%% 	check wa yoo nai open list mai
%% 	check wa mai yoo nai both open list and closed list lae add kai soo frontier



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
	

%% add_to_closedList((3,0),80).

%% get_cost_of((3,0),0).

a_star(Start,Destination,Path):-
	retractall(parent_of(_,_)),
	retractall(add_to_closedList(_,_)),
	get_HX(Start,Destination,Cost),
	assert(add_to_closedList(Start,Cost)),
	assert(parent_of(Start,Start)),
	search(Start,Destination,heap(nil,0),Path).
	%% removeAtIndex(TempPath,0,Path).


removeAtIndex([_|T],0,T).
removeAtIndex([H|T],Index,[H|Res]):-
	Index > -1,
	Counter is Index - 1,
	removeAtIndex(T,Counter,Res).

indexOf([X|_],X,0).
indexOf([_|T],Element,Index):- 
	indexOf(T,Element,I),
	!, 
	Index is I + 1.


and(A,B):- is_true(A), is_true(B).
or(A,B):- is_true(A) ; is_true(B).

is_true(true).      %// no need to include any cases with false, it'll fail anyway
is_true(A):- var(A), !, false.  %// prevent it from generating too much stuff
is_true(and(A,B)):- and(A,B).
is_true(or(A,B)):- or(A,B).    



search(Current,Destination,OpenList,Path):-
	Current == Destination,
	append([],[Destination],Path),
	!.


search(Current,Destination,OpenList,Path):-
	%% get all neibors of current node
	get_neighbors(Current,NeigborList),

	%% add each neibor to open list 
	add_to_closedList(Current,CurrentTotalCost),
	add_to_openList(NeigborList,Current,CurrentTotalCost,Destination,OpenList,AfterAddedNeibor_OpenList),

	%%pop node with least value from heap
	get_from_heap(AfterAddedNeibor_OpenList,Value,NextNode,ResOpenList),
	%%add pop node with cost to closed list
	assert(add_to_closedList(NextNode,Value)),


	search(NextNode,Destination,ResOpenList,[H|T]),
	parent_of(H,Parent),
	%%append to pathlist if not in pathlist
	(H = Parent -> 
		append([],[H|T],Path)
		;
		append([Parent],[H|T],Path)
		).
	


add_to_openList([],CurrentNode,CurrentNodeTotal,DestinationNode,OpenList,OpenList).

add_to_openList([H|T],CurrentNode,CurrentNodeTotal,DestinationNode,OpenList,AfterNeigborAddedOpenList):-
	%% Calculate g cost of the current neigbor node
	get_HX(CurrentNode,DestinationNode,CurrentNode_HX),
	CurrentNeigbor_GX is CurrentNodeTotal - CurrentNode_HX + 10,

	%%get current neigbor node HX 
	get_HX(H,DestinationNode,HNode_HX),


	


	%% Check current neibor node if is in ClosedList
	(add_to_closedList(H,HNode_Value)-> 

		InClosedListValue_GX is HNode_Value - HNode_HX,
		%%check if current neigbor node g cost < already in closedlist node g cost
		(CurrentNeigbor_GX < InClosedListValue_GX -> 
			%%remove the node from the closed list
			retract(add_to_closedList(H,HNode_Value)),
			parent_of(H,H_Parent),
			retract(parent_of(H,H_Parent))
			;
			true
			)
		;
		true

	),

	%%Check current neibor node if is in OpenList
	(delete_from_heap(OpenList,HNode_Value2,H,TempHeap2) ->
			InOpenListValue_GX is HNode_Value2 - HNode_HX,
			%%check if current neigbor node g cost < already in openlist node g cost
			(CurrentNeigbor_GX < InOpenListValue_GX ->
				parent_of(H,H_Parent2),
				retract(parent_of(H,H_Parent2))
				;
				true
				)
				
		;
		merge_heaps(heap(nil,0),OpenList,TempHeap2)
		),




	%%Add to Openlist if not in both
	(add_to_closedList(H,HNode_Value) ->
		merge_heaps(heap(nil,0),TempHeap2,ResOpenList)
		;
		(delete_from_heap(TempHeap2,HNode_Value2,H,DummyHeap) ->
			merge_heaps(heap(nil,0),TempHeap2,ResOpenList)
			;
			CurrentNeigbor_TotalCost is CurrentNeigbor_GX + HNode_HX,
			add_to_heap(TempHeap2,CurrentNeigbor_TotalCost,H,ResOpenList),
			assert(parent_of(H,CurrentNode))
			)
		),
	

	
	add_to_openList(T,CurrentNode,CurrentNodeTotal,DestinationNode,ResOpenList,AfterNeigborAddedOpenList).

get_GX(Node,GX):-
	get_cost_of(Node,Cost),
	GX is Cost + 10.

get_HX(Node,Destination,HX):-
	get_coordinate(Node,X1,Y1),
	get_coordinate(Destination,X2,Y2),
	abs(X2-X1,XB),
	abs(Y2-Y1,XY),
	HX is (XB + XY) * 10.

get_neighbors(Current,ResList):-
	findall(X,connected_block(Current,X),ResList).

















































tree(0,0).
tree(0,1).
tree(0,3).

tree(1,4).

tree(2,2).

tree(3,3).

tree(4,1).
tree(4,3).
tree(4,4).
tree(4,5).

tree(5,1).




dirt(0,2).
dirt(0,4).
dirt(0,5).

get_coordinate((0,2),0,2).
get_coordinate((0,4),0,4).
get_coordinate((0,5),0,5).

dirt(1,0).
dirt(1,1).
dirt(1,2).
dirt(1,3).
dirt(1,5).

get_coordinate((1,0),1,0).
get_coordinate((1,1),1,1).
get_coordinate((1,2),1,2).
get_coordinate((1,3),1,3).
get_coordinate((1,5),1,5).


dirt(2,0).
dirt(2,1).
dirt(2,3).
dirt(2,4).
dirt(2,5).

get_coordinate((2,0),2,0).
get_coordinate((2,1),2,1).
get_coordinate((2,3),2,3).
get_coordinate((2,4),2,4).
get_coordinate((2,5),2,5).


dirt(3,0).
dirt(3,1).
dirt(3,2).
dirt(3,4).
dirt(3,5).

get_coordinate((3,0),3,0).
get_coordinate((3,1),3,1).
get_coordinate((3,2),3,2).
get_coordinate((3,4),3,4).
get_coordinate((3,5),3,5).


dirt(4,0).
dirt(4,2).

get_coordinate((4,0),4,0).
get_coordinate((4,2),4,2).




dirt(5,0).
dirt(5,2).
dirt(5,3).
dirt(5,4).
dirt(5,5).

get_coordinate((5,0),5,0).
get_coordinate((5,2),5,2).
get_coordinate((5,3),5,3).
get_coordinate((5,4),5,4).
get_coordinate((5,5),5,5).

goal(0,5).
get_coordinate(goal(0,5),0,5).



%%connection block
%%row0
connected_block((0,2),(1,2)).

connected_block((0,4),(0,5)).

connected_block((0,5),(0,4)).
connected_block((0,5),(1,5)).

%%row1
connected_block((1,0),(2,0)).
connected_block((1,0),(1,1)).

connected_block((1,1),(1,0)).
connected_block((1,1),(1,2)).
connected_block((1,1),(2,1)).

connected_block((1,2),(1,1)).
connected_block((1,2),(0,2)).
connected_block((1,2),(1,3)).

connected_block((1,3),(1,2)).
connected_block((1,3),(2,3)).

connected_block((1,5),(0,5)).
connected_block((1,5),(2,5)).

%%row2
connected_block((2,0),(1,0)).
connected_block((2,0),(2,1)).
connected_block((2,0),(3,0)).

connected_block((2,1),(2,0)).
connected_block((2,1),(1,1)).
connected_block((2,1),(3,1)).

connected_block((2,3),(1,3)).
connected_block((2,3),(2,4)).

connected_block((2,4),(2,3)).
connected_block((2,4),(2,5)).
connected_block((2,4),(3,4)).

connected_block((2,5),(2,4)).
connected_block((2,5),(1,5)).
connected_block((2,5),(3,5)).

%%row3
connected_block((3,0),(2,0)).
connected_block((3,0),(3,1)).
connected_block((3,0),(4,0)).

connected_block((3,1),(3,0)).
connected_block((3,1),(2,1)).
connected_block((3,1),(3,2)).

connected_block((3,2),(3,1)).
connected_block((3,2),(4,2)).

connected_block((3,4),(2,4)).
connected_block((3,4),(3,5)).

connected_block((3,5),(3,4)).
connected_block((3,5),(2,5)).

%%row4
connected_block((4,0),(3,0)).
connected_block((4,0),(5,0)).

connected_block((4,2),(3,2)).
connected_block((4,2),(5,2)).

%%row5
connected_block((5,0),(4,0)).

connected_block((5,2),(4,2)).
connected_block((5,2),(5,3)).

connected_block((5,3),(5,2)).
connected_block((5,3),(5,4)).

connected_block((5,4),(5,3)).
connected_block((5,4),(5,5)).

connected_block((5,5),(5,4)).
	














