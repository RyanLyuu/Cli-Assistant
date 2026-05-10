package hamster_commander.llm_caller

import stdx.serialization.serialization.*
import stdx.encoding.json.*

public class GeneralRequest <: Serializable<GeneralRequest> {
    public GeneralRequest(
        public var model: String,
        public var messages: Array<GeneralRequestMessage>
    ) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<String>("model", model)).add(field<Array<GeneralRequestMessage>>("messages", messages)
        )
    }
    public static func deserialize(dm: DataModel): GeneralRequest {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        GeneralRequest(
            String.deserialize(dms.get("model")),
            Array<GeneralRequestMessage>.deserialize(dms.get("messages"))
        )
    }
}

public class GeneralRequestMessage <: Serializable<GeneralRequestMessage> {
    public GeneralRequestMessage(
        public var role: String,
        public var content: String
    ) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<String>("role", role)).add(field<String>("content", content))
    }
    public static func deserialize(dm: DataModel): GeneralRequestMessage {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        GeneralRequestMessage(
            String.deserialize(dms.get("role")),
            String.deserialize(dms.get("content"))
        )
    }
}
