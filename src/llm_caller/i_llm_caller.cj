package cangjie_pj.llm_caller

import std.env.*

public interface ILlmCaller {
    func call(messages: Array<Message>): Message

    static func createDefault(): ILlmCaller {
        return ModelArtsLlmCaller(
            getVariable(ModelArtsLlmCaller.ModelArtsApiAddress) ?? throw Exception(
                "missing environment variable ${ModelArtsLlmCaller.ModelArtsApiAddress}"),
            getVariable(ModelArtsLlmCaller.ModelArtsApiPassword) ?? throw Exception(
                "missing environment variable ${ModelArtsLlmCaller.ModelArtsApiPassword}"),
            getVariable(ModelArtsLlmCaller.ModelArtsModelName) ?? throw Exception(
                "missing environment variable ${ModelArtsLlmCaller.ModelArtsModelName}")
        )
    }
}
