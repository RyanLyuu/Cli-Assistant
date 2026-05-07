package hamster_commander.llm_caller

import stdx.serialization.serialization.*
import stdx.encoding.json.*

public class GeneralSuccessResponse <: Serializable<GeneralSuccessResponse> {
    public GeneralSuccessResponse(public var choices: Array<GeneralSuccessResponseChoice>) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<Array<GeneralSuccessResponseChoice>>("choices", choices))
    }
    public static func deserialize(dm: DataModel): GeneralSuccessResponse {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        GeneralSuccessResponse(Array<GeneralSuccessResponseChoice>.deserialize(dms.get("choices")))
    }
}

public class GeneralSuccessResponseChoice <: Serializable<GeneralSuccessResponseChoice> {
    public GeneralSuccessResponseChoice(public var message: GeneralSuccessResponseChoiceMessage) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<GeneralSuccessResponseChoiceMessage>("message", message))
    }
    public static func deserialize(dm: DataModel): GeneralSuccessResponseChoice {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        GeneralSuccessResponseChoice(GeneralSuccessResponseChoiceMessage.deserialize(dms.get("message")))
    }
}

public class GeneralSuccessResponseChoiceMessage <: Serializable<GeneralSuccessResponseChoiceMessage> {
    public GeneralSuccessResponseChoiceMessage(
        public var role: String,
        public var content: String
    ) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<String>("role", role)).add(field<String>("content", content))
    }
    public static func deserialize(dm: DataModel): GeneralSuccessResponseChoiceMessage {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        GeneralSuccessResponseChoiceMessage(
            String.deserialize(dms.get("role")),
            String.deserialize(dms.get("content"))
        )
    }
}
