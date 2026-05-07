package hamster_commander.llm_caller

import stdx.serialization.serialization.*
import stdx.encoding.json.*

public class SparkErrorResponse <: Serializable<SparkErrorResponse> {
    public SparkErrorResponse(public var error: SparkErrorMessageError) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<SparkErrorMessageError>("error", error))
    }
    public static func deserialize(dm: DataModel): SparkErrorResponse {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        SparkErrorResponse(SparkErrorMessageError.deserialize(dms.get("error")))
    }
}

public class SparkErrorMessageError <: Serializable<SparkErrorMessageError> {
    public SparkErrorMessageError(public var message: String) {}
    public func serialize(): DataModel {
        DataModelStruct().add(field<String>("message", message))
    }
    public static func deserialize(dm: DataModel): SparkErrorMessageError {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        SparkErrorMessageError(String.deserialize(dms.get("message")))
    }
}
