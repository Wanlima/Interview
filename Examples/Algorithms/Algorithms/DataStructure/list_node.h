//
//  list_node.h
//  Algorithms
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#ifndef list_node_h
#define list_node_h

#include <stdio.h>

typedef struct list_node ListNode;

struct list_node {
    int value;
    struct list_node *next;
};

/*
 Create a linked list from an array
 */
ListNode createLinkedList(int * array);

#endif /* list_node_h */
