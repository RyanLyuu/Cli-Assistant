package cangjie_pj

import cangjie_pj.llm_caller.*

public class Commander{
    let apiKey: String 
    let apiSecret: String 
    let systemMessage: Message
    let llmCaller: SparkLlmCaller

    public Commander(){
        apiKey = "ad162fef9b47b3a45209e3b50c2936e5"
        apiSecret = "MmVkMGViMThmZDlhMTU2MWU0MWVmODJk"  
        systemMessage = Message(
            "system",
            "你是一个将用户的需求翻译成命令行命令的机器人。你将用户发来的需求，翻译成命令。你只返回一行命令，确保不要包含任何其他内容"
        )
        llmCaller = SparkLlmCaller(apiKey)
    }

    public func generateCommand(intent: String): String {
        let responseMessage = llmCaller.call([Message("user", intent)])
        return responseMessage.content
    }
}