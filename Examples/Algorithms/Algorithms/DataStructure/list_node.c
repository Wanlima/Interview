//
//  list_node.c
//  Algorithms
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#include "list_node.h"

ListNode createLinkedList(int * array) {
    int length = sizeof(*array)/sizeof(array[0]);
    printf("%d\n", length);
    ListNode node;
    node.value = array[0];
    return node;
}
