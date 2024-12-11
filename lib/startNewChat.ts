import client from "@/graphql/apolloClient";
import {INSERT_CHAT_SESSION, INSERT_GUEST, INSERT_MESSAGE} from "@/graphql/mutations/mutations";
async function startNewChat(
     guestName:string,
     guestEmail:string,
     chatbotId:number
){
    try {
        //1.Create a new guest entry

        const guestResult = await client.mutate({
            mutation:INSERT_GUEST,
            variables:{name:guestName ,
                email:guestEmail,
                created_at: new Date().toISOString()},
        });
        const guestId =guestResult.data.insertGuests.id;

        //2 . Initialize a new chat session
        const chatSessionResult = await client.mutate({
            mutation:INSERT_CHAT_SESSION,
            variables:{chatbot_id:chatbotId,guest_id:guestId,
                created_at: new Date().toISOString()
            },
        });
        const chatSessionId =chatSessionResult.data.insertChat_sessions.id;

        //3.Insert initial message (optional)
        await client.mutate({
            mutation:INSERT_MESSAGE,
            variables:{
                chat_session_id:chatSessionId,
                created_at: new Date().toISOString(),
                sender:"ai",
                content:`Welcome ${guestName}!\n How can I assist you today? 😉`,
            },
        });

        console.log("New chat session started successfully");
        return chatSessionId;
    } catch (error) {
        console.error("Error starting new chat session:",error);
        
    }
}
export default startNewChat;
