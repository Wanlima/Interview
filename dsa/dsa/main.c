//
//  main.c
//  dsa
//
//  Created by Passion on 2020/4/26.
//  Copyright © 2020 Passion. All rights reserved.
//

#include <stdio.h>
#include "list_node.h"

int main(int argc, const char * argv[]) {
    
    Node listNode, next;
    listNode.value = 1;
    next.value = 2;
    listNode.next = &next;
    
    char *str = "passion";
    
    helloworld(str);
    
    return 0;
}
