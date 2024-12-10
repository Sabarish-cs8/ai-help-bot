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
  deleteChatbot_characteristic(id:$characteristic.Id){
    id
    # Add other fields your might want to return after removal
  }}
  `;
 