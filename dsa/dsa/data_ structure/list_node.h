//
//  list_node.h
//  dsa
//
//  Created by Passion on 2020/4/26.
//  Copyright © 2020 Passion. All rights reserved.
//

#ifndef list_node_h
#define list_node_h

#include <stdio.h>

struct ListNode {
    int value;
    struct ListNode *next;
};

typedef struct ListNode Node;

void helloworld(char *str);

#endif /* list_node_h */
