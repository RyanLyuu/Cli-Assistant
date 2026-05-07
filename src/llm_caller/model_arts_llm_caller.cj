package hamster_commander.llm_caller

import stdx.encoding.json.*
import stdx.net.http.*
import stdx.net.tls.*
import stdx.serialization.serialization.*
import std.collection.*
import std.io.*
import std.time.*

public class ModelArtsLlmCaller <: ILlmCaller {
    public ModelArtsLlmCaller(private let apiAddress: String, private let apiPassword: String,
        private let modelName: String) {}

    public static const ModelArtsApiAddress: String = "ModelArtsApiAddress"
    public static const ModelArtsApiPassword: String = "ModelArtsApiPassword"
    public static const ModelArtsModelName: String = "ModelArtsModelName"

    public func call(messages: Array<Message>): Message {
        let requestJson = GeneralRequest(
            modelName,
            messages |> map {p => GeneralRequestMessage(p.role, p.content)} |> collectArray
        ).serialize().toJson().toJsonString()

        var tlsConfig = TlsClientConfig()
        tlsConfig.verifyMode = TrustAll
        let response = HttpRequestBuilder()
            .readTimeout(Duration.Max)
            .method("POST")
            .url(apiAddress)
            .header("Content-Type", "application/json")
            .header("Authorization", "Bearer ${apiPassword}")
            .body(requestJson)
            .build() |> ClientBuilder().readTimeout(Duration.Max).tlsConfig(tlsConfig).build().send

        if (response.status != 200) {
            throw Exception("invalid http response status: ${response.status}")
        }

        let responseJson = StringReader(response.body).readToEnd()

        let successResponse: GeneralSuccessResponse
        successResponse = responseJson |> JsonValue.fromStr |> DataModel.fromJson |> GeneralSuccessResponse.deserialize

        if (successResponse.choices.size == 0) {
            throw Exception("empty choices")
        }

        return Message(successResponse.choices[0].message.role, successResponse.choices[0].message.content)
    }
}
