- 引入第三方库需要修改cjpm.toml 中dependencies
- 引用时必须使用源项目名

```
[dependencies]
  hamster_commander_toolkit  = { git = "https://gitcode.com/zhangyin_gitcode/hamster_commander_toolkit.git" }
```

- cangjie去git拉取并编译

- **添加第三方库后使用'cjpm update'拉取**
