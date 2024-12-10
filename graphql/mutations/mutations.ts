import {gql} from "@apollo/client";

export const CREATE_CHATBOT=gql`
      mutation CreateChatbot($clerk_user_id: String!, $name: String!, $created_at: DateTime!) {
    insertChatbots(clerk_user_id: $clerk_user_id, name: $name, created_at: $created_at) {
      id
      clerk_user_id
      name
      created_at
    }
  }`;

  export const REMOVE_CHARACTERISTIC=gql`
  mutation RemoveCharacteristic($characteristicId:Int!){
  deleteChatbot_characteristic(id:$characteristicId){
    id
    # Add other fields your might want to return after removal
  }}
  `;

  export const DELETE_CHATBOT = gql`
  
   mutation DeleteChatbot($id:Int!){
   deleteChatbots(id:$id){
   id
   }
   }
  `;
 

  export const ADD_CHARACTERISTIC=gql`
   
  mutation AddCharacteristic($chatbotId:Int!,$content:String!,$created_at: DateTime!){
  insertChatbot_characteristics(chatbot_id:$chatbotId,content:$content,created_at: $created_at){
  id
  content
  created_at
  # Add other fields you might want to return after adding
  }
  }  
  `;