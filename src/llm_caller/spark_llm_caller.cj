package hamster_commander.llm_caller

import stdx.encoding.json.*
import stdx.net.http.*
import stdx.net.tls.*
import stdx.serialization.serialization.*
import std.collection.*
import std.io.*
import std.time.*

public class SparkLlmCaller <: ILlmCaller {
    public SparkLlmCaller(private let apiPassword: String) {}

    public static const SparkApiPassword: String = "SparkApiPassword"

    public func call(messages: Array<Message>): Message {
        let requestJson = GeneralRequest(
            "4.0Ultra",
            messages |> map {p => GeneralRequestMessage(p.role, p.content)} |> collectArray
        ).serialize().toJson().toJsonString()

        var tlsConfig = TlsClientConfig()
        tlsConfig.verifyMode = TrustAll
        let response = HttpRequestBuilder()
            .readTimeout(Duration.Max)
            .method("POST")
            .url("https://spark-api-open.xf-yun.com/v1/chat/completions")
            .header("Content-Type", "application/json")
            .header("Authorization", "Bearer ${apiPassword}")
            .body(requestJson)
            .build() |> ClientBuilder().readTimeout(Duration.Max).tlsConfig(tlsConfig).build().send

        if (response.status != 200) {
            throw Exception("invalid http response status: ${response.status}")
        }

        let responseJson = StringReader(response.body).readToEnd()

        let successResponse: GeneralSuccessResponse
        try {
            successResponse = responseJson |> JsonValue.fromStr |> DataModel.fromJson |> GeneralSuccessResponse
                .deserialize
        } catch (_: Exception) {
            try {
                let sparkErrorResponse = responseJson |> JsonValue.fromStr |> DataModel.fromJson |> SparkErrorResponse
                    .deserialize
                throw Exception(sparkErrorResponse.error.message)
            } catch (_: Exception) {
                throw Exception(responseJson)
            }
        }

        if (successResponse.choices.size == 0) {
            throw Exception("empty choices")
        }

        return Message(successResponse.choices[0].message.role, successResponse.choices[0].message.content)
    }
}

let _ = {=> SparkLlmCaller.SparkApiPassword}()
