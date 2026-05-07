package hamster_commander.test

import stdx.crypto.crypto.*
import std.unittest.*
import std.unittest.testmacro.*
import hamster_commander.* //同目录可见性，所以子目录需要引入


@Test
public class SecretStoreTest{
    //new一个对象用作全局测试
    private let secretStore = SecretStore()
    
    //helper
    public func randomKey(prefix: String): String{
        let secureRandom = SecureRandom()
        return prefix + "_" + secureRandom.nextInt64().toString()
    }
    @TestCase
    public func test_set_then_get_return(){
        let key = randomKey("test_set_get")
        let value = "test_secret_value"

        secretStore.set(key, value)

        let result = secretStore.get(key)

        @Expect(result, value)
    }
    
    @TestCase
    public func test_get_non_exising_key(){
        let key = randomKey("non_exising_key")

        let result = secretStore.get(key)

        @Expect(result, None)
    }

}