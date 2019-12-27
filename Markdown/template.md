# 一级标题
## 二级标题
### 三级标题

**加粗**\
*斜体*\
~~删除线~~

[本地文件](res/CommonMark.md)\
[链接](https://commonmark.org/help/)\
<https://commonmark.org>\
[共用相同链接][1]\
[共用相同链接][1]

[1]:https://commonmark.org/


![本地图片](./res/CommonMark.png)\
![网络图片](https://commonmark.org/help/images/favicon.png)\
![共用相同图片][logo]\
![共用相同图片][logo]

[logo]:./res/CommonMark.png


[锚点](#一级标题)

> 区块引用
>
>> 二级引用

* 一级无序列表
  1. 插入有序列表
  2. 插入有序列表
  * 二级无序列表\
    插入\
    段落
    * 三级无序列表

1. 一级有序列表\
    插入\
    段落
2. 二级有序列表
3. 三级有序列表

---

普通语句中插入`内联代码`
```C
//插入代码块
int main(){
    printf("Hello World!");
    return 0;
}
```

在一个段落中\
进行换行

\*转义字符

| 左对齐 | 居中对齐 | 右对齐 |
|:-------|:--------:|-------:|
| 左     |    中    |     右 |
| 👈     |    🎯    |     👉 |
注:表格一般用**插件**生成，而不是去写

[锚点](#三级标题)

TeX表达式
$-b \pm \sqrt{b^2 - 4ac} \over 2a$