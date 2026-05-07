package hamster_commander

import std.env.*
import std.fs.*
import std.io.*

class SecretStore{
    let secretStorePath: Path = Path("/tmp").join("hamster_commander")

    public func set(key: String, value: String): Unit {
        if (!exists(secretStorePath)) {
            Directory.create(secretStorePath)
}
        // 将key-value对写入临时目录下独立文件中
        let secretStoreFilePath = secretStorePath.join(key)//TODO 此处假设key是合法值
        
        try(secretStoreFile = File.create(secretStoreFilePath), 
            secretStoreFileWriter = StringWriter(secretStoreFile)){
                secretStoreFileWriter.write(value)
        }


        throw Exception("Not implemented yet")
    }

    public func get(key: String): Option<String>{
        let secretStoreFilePath = secretStorePath.join(key)
        if( !exists(secretStoreFilePath)){
            return None
        }

        let bytes = File.readFrom(secretStoreFilePath)
        return String.fromUtf8(bytes)

        throw Exception("This should not happen")

    }
}