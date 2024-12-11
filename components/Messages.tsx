"use client"; 

import { Message } from '@/types/types';
import React from 'react'

function Messages({messages , chatbotName}:{
    messages:Message[];
    chatbotName:string;
}) {
   

    return (
    <div>Messages</div>
  )
}

export default Messages