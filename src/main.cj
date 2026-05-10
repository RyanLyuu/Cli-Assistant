//空目录cjpm init 自动生成src及main.cj(如果已有自建src, 则行为仅有构建cjpm.toml)
package hamster_commander

import hamster_commander.llm_caller.*

main(args: Array<String>): Int64 {
    if(args.isEmpty()){ 
        println("Please give an instruction!")
        return 0
    }

    println(args[0])
    return 0
}

//Cangjie 允许函数独立于类存在
func generateCommand(intent: String): String{
    return Commander().generateCommand(intent)
}