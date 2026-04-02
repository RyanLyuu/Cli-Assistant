//空目录cjpm init 自动生成src及main.cj(如果已有自建src, 则行为仅有构建cjpm.toml)
package cangjie_pj

main(): Int64 {
    let message = "hello world" 
    //let message: String = "hello world"
    //TS风格 let关键字声明变量，变量名在前，类型在后
    //此处不加:String 编译器也可推断
    //let声明不可变变量，即可读变量
    //var声明可变变量

    //声明规范:
    //局部变量通常不写类型，类属性必须声明类型
    println(message)
    return 0
}
