# C++学习记录  

## 指针  
    所有类型（class、struct、enum等），在未使用*标记未指针的情况下，均为值类型，存储的是值的地址（使用&获取的地址）  
    delete用于释放指针，所有指针都需要释放（无论是手动还是CIL释放），不能释放值类型地址  
      
    * 关于指针常见的错误：  
      * 使用指针时最常见的错误之一是取消引用未初始化或空指针。这可能会导致分段错误或其他与内存相关的错误。为避免这种情况，请始终确保初始化指向有效内存地址的指针，如果它们不指向任何内容，则将其设置为 null  
      * 使用无效的内存地址或越界的指针算术。这可能导致不可预测的行为，甚至安全漏洞。在取消引用之前，请务必验证指针是否指向有效的内存地址，并使用适当的边界检查防止越界错误的技术  
      * 内存泄漏是使用指针时的另一个常见问题。当使用 new 或 malloc 动态分配内存，但不再使用 delete 或 free 释放内存时，会发生这种情况。随着时间的流逝，这可能会导致程序消耗大量内存，甚至崩溃。为避免内存泄漏，请始终确保在完成后释放动态分配的内存  
      * 请注意指针赋值和值赋值之间的区别。将一个指针分配给另一个指针时，复制的是内存地址，而不是指针指向的值  




## 多线程  
  
     当一段上下文（函数、代码块）被多线程访问时，需要考虑冲突问题，一般使用临界区进行冲突问题的解决。  
* 临界区  
    


## 访问控制  

* private ：只能被声明的类的成员函数和友元（类或函数）访问  
* protected： 在private的基础上，增加可被继承类的成员函数访问  
* public：在protected的基础上，还可被类实例化的对象访问  

## 嵌套类  

* 嵌套类只能从封闭类中直接使用名称、类型名称，静态成员的名称和枚举数。 若要使用其他类成员的名称，您必须使用指针、引用或对象名  
* 嵌套类仅在类范围内声明类型。 它们不会导致创建嵌套类的包含对象  
* 

### Const  
[参考资料：const关键字](https://www.geeksforgeeks.org/const-keyword-in-cpp/)
*  常量变量：const long double PI = 3.14159265;  
*  常量指针（二者等效）：cosnt class * myClass; 或 class const * myClass;  
*  指针常量: class * const myClass;  
*  表示类成员函数不会修改类成员变量：   
~~~ 
class myClass
{
  public:
    string GetName() const;
    //...
  private:
    string _name;
}
~~~  

### 引用类型、指针类型和值类型  
[参考资料：何时使用指针](https://www.geeksforgeeks.org/when-do-we-pass-arguments-by-reference-or-pointer/)  
[参考资料：指针和引用](https://www.geeksforgeeks.org/pointers-vs-references-cpp/)  
此三种类型形如:  
~~~  
    refernce& ref;
    refernce* pref;
    refernce val;
~~~  

* 引用类型：引用类型存储地址，它是一个存储地址的常量。引用类型只是一个变量的别名，它体现了这个变量的所有，并不是一个变量  
* 指针：指针存储地址，他是个一个存储地址的变量。指针变量具备自身的地址（该地址不同于变量指向的地址）  
~~~
//example1
int i=10;
int &x=i;
int *y=&i;
// y 是变量i的地址，&y是变量y的地址  
// x 是变量i的值，&x是变量i的地址  
// i 是i的值，&i是i的地址  
~~~  








### 界面开发  

* 界面更改通知变量：UpdateData(true)  
* 变量更改通知界面：UpdateData(false)  
*   



## Socket  
[官方文档](https://learn.microsoft.com/zh-cn/windows/win32/api/winsock2/)  

* 套接字函数创建绑定到特定传输服务提供程序的套接字  
~~~
SOCKET WSAAPI socket(
  [in] int af,
  [in] int type,
  [in] int protocol
);
~~~  
  
 * [in] af   
 地址系列规范。 地址系列的可能值在 Winsock2.h 头文件中定义。    
 在为 Windows Vista 及更高版本发布的Windows SDK中，头文件的组织方式已更改，地址系列的可能值在 Ws2def.h 头文件中定义。 请注意， Ws2def.h 头文件会自动包含在 Winsock2.h 中，永远不应直接使用。  
 当前支持的值是 AF_INET 或 AF_INET6，它们是 IPv4 和 IPv6 的 Internet 地址系列格式   
  * [in] type  
  新套接字的类型规范。  
  套接字类型的可能值在 Winsock2.h 头文件中定义。  
  Windows套接字2支持的类型参数的可能值：SOCK_STREAM、SOCK_DGRAM  
  * [in] protocol  
  要使用的协议。 协议参数的可能选项特定于指定的地址系列和套接字类型。 协议的可能值在 Winsock2.h 和 Wsrm.h 头文件中定义  
  常见值：IPPROTO_TCP  


socket  
套接字函数创建绑定到特定传输服务提供程序的套接字。  
recv  
recv 函数 (winsock2.h) 从连接的套接字或绑定的无连接套接字接收数据。  
listen  
侦听函数将套接字置于侦听传入连接的状态。  
connect  
connect 函数与指定的套接字建立连接。  
closesocket  
closesocket 函数关闭现有套接字。 (closesocket 函数 (winsock2.h) )  
bind  
bind 函数将本地地址与套接字相关联。 (bind 函数 (winsock2.h) )  
accept  
accept 函数允许在套接字上进行传入连接尝试。







## 注意事项  

* 模板类（泛型）的模板函数需要在声明时定义  
* 






# 设计模式  

## Singleton模式  
~~~
class CSingletonTest
{
public:
    static CSingletonTest& GetTest();
    static void RunThread();


private:
    CSingletonTest() {};
    ~CSingletonTest() {};
    //CSingletonTest(const CSingletonTest&);
    const CSingletonTest& operator=(const CSingletonTest& test) {};
};
CSingletonTest& CSingletonTest::GetTest()
{
    static CSingletonTest test;
    return test;
}
~~~