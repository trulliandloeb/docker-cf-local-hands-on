# Part 1
## Start from: https://github.com/SAP/cloud-bulletinboard-ads
### Branch: solution-11-Develop-Custom-Queries
### Demo for this branch after deployed to CF:
* List all [GET] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads>
* Add one [POST] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads>

  ```json
  {
    "title": "test"
  }
  ````
* Update one [PUT] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads/{id}>

  ```json
  {
      "title": "test3update",
      "id": "3",
      "metadata": {
          "version": "2"
      }
  }
  ```
* Delete one [DELETE] <https://bill-bulletinboard-ads.cfapps.us30.hana.ondemand.com/api/v1/ads/{id}>
## Target 1: Debug it on CF
Reference
---
* [JDWP](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/introclientissues005.html)
* [JPDA](https://docs.oracle.com/javase/8/docs/technotes/guides/jpda/conninv.html#Invocation)
* [Java HotSpot VM Options](https://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html)
* [-X Command-line Options](https://docs.oracle.com/cd/E13150_01/jrockit_jvm/jrockit/jrdocs/refman/optionX.html)
* [New Cloud Foundry Java Buildpack Improves Developer Diagnostic Tools](https://content.pivotal.io/blog/new-cloud-foundry-java-buildpack-improves-developer-diagnostic-tools)
* [What are Java command line options to set to allow JVM to be remotely debugged?](https://stackoverflow.com/questions/138511/what-are-java-command-line-options-to-set-to-allow-jvm-to-be-remotely-debugged)
* [How do I use the JAVA_OPTS environment variable?](https://stackoverflow.com/questions/5241743/how-do-i-use-the-java-opts-environment-variable)
* [Accessing Apps with SSH](https://docs.cloudfoundry.org/devguide/deploy-apps/ssh-apps.html)
---
We <span style="color:red;">cannot</span> debug use the same process on CF.

We need use <span style="color:blue;">remote debug</span>.
1. CF provide an easy way

set environment variable ***JBP_CONFIG_DEBUG*** to ***{enabled: true}***

cf set-env bill-bulletinboard-ads JBP_CONFIG_DEBUG '{enabled: true}'

cf ssh -L ***8000:localhost:8000*** bill-bulletinboard-ads

2. Use original way

add arguments ***-Xdebug -Xrunjdwp*** to jvm

cf set-env bill-bulletinboard-ads JAVA_OPTS '-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8999'
## Target 2: Debug it on local
**Exclusion**

How does docker design, work and implement
### What is docker
Docker is a computer **program** that performs **operating-system-level virtualization**. It was first released in 2013 and is developed by Docker, Inc.

Docker is used to run **software packages** called ***containers***. Containers are **isolated** from each other and bundle their **own** application, tools, libraries and configuration files; they can **communicate** with each other through well-defined channels. All containers are run by a single operating-system kernel and are thus more **lightweight** than virtual machines. Containers are created from ***images*** that specify their precise contents. Images are often created by *combining and modifying standard images* downloaded from public repositories.

---
**History**

Solomon Hykes started Docker in France as an internal project within dotCloud, a platform-as-a-service company, with initial contributions by other dotCloud engineers including Andrea Luzzardi and Francois-Xavier Bourlet. Jeff Lindsay also became involved as an independent collaborator. Docker represents an evolution of dotCloud's proprietary technology, which is itself built on earlier open-source projects such as Cloudlets.

The software debuted to the public in Santa Clara at PyCon in 2013.

Docker was released as open source in March 2013. On March 13, 2014, with the release of version 0.9, Docker dropped *LXC* as the default execution environment and replaced it with its *own libcontainer library written in the Go programming language*.

* On September 19, 2013, Red Hat and Docker announced a collaboration around Fedora, Red Hat Enterprise Linux, and OpenShift.
* In November 2014 Docker container services were announced for the Amazon Elastic Compute Cloud (EC2).
* On November 10, 2014, Docker announced a partnership with Stratoscale.
* On December 4, 2014, IBM announced a strategic partnership with Docker that enables Docker to integrate more closely with the IBM Cloud.
* On June 22, 2015, Docker and several other companies announced that they are working on a new vendor and operating-system-independent standard for software containers.
* As of October 24, 2015, the project had over 25,600 GitHub stars (making it the 20th most-starred GitHub project), over 6,800 forks, and nearly 1,100 contributors.
* In April 2016, Windocks, an independent ISV released a port of Docker's open source project to Windows, supporting Windows Server 2012 R2 and Server 2016, with all editions of SQL Server 2008 onward.
* A May 2016 analysis showed the following organizations as main contributors to Docker: The Docker team, Cisco, Google, Huawei, IBM, Microsoft, and Red Hat.
* On October 4, 2016, Solomon Hykes announced InfraKit as a new self-healing container infrastructure effort for Docker container environments.
* A January 2017 analysis of LinkedIn profile mentions showed Docker presence grew by 160% in 2016.
---
```shell
docker version
```
Hyper-v: use on Windows
### Image
> *If need* \<docker image rm hello-world\>
```shell
docker image pull hello-world
docker image ls -a
```
### Container
```shell
docker run hello-world
docker container ls -a
docker container start -i {container-id}
docker container rm {container-id}
```
### Start from [PostgreSQL](https://hub.docker.com/_/postgres)
```shell
docker run
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    postgres:9.4-alpine
```
Expose the port
```shell
docker run --rm \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    -p 127.0.0.1:5432:5432 \
    postgres:9.4-alpine
```
Use psql client in Docker
```shell
docker run --rm \
    --name some-postgres-client \
    -it \
    --network host \
    postgres:9.4-alpine psql \
    -h localhost -U testuser -d test
```
```SQL
\c
\d
CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);
INSERT INTO user_tbl(name, signup_date) VALUES('张三', '2013-12-22');
SELECT * FROM user_tbl;
\q
```
Better way to use psql
```shell
#if need
#docker network rm bill-network
docker network ls
docker network create bill-network
docker run --rm \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    --network bill-network \
    postgres:9.4-alpine
docker run --rm \
    --name some-postgres-client \
    -it \
    --network bill-network \
    postgres:9.4-alpine psql \
    -h some-postgres -U testuser -d test
```
Debug the app directly from local, expose the port

Debug from maven:
```shell
export MAVEN_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:8000'
mvn tomcat7:run
```
Debug from Tomcat:
```shell
cd path/to/tomcat
export CATALINA_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:8000'
./bin/catalina.sh start
tail -f ./logs/catalina.out
./bin/catalina.sh stop
```
### Reference
* <https://docs.docker.com/engine/reference/run/>
* <http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html>
## Target 3: Make a image and run local
docker network

docker build

## Question? Introduce to next part
deploy the image to CF

container dependency

docker-compose

# 欢迎使用 Cmd Markdown 编辑阅读器

------

我们理解您需要更便捷更高效的工具记录思想，整理笔记、知识，并将其中承载的价值传播给他人，**Cmd Markdown** 是我们给出的答案 —— 我们为记录思想和分享知识提供更专业的工具。 您可以使用 Cmd Markdown：

> * 整理知识，学习笔记
> * 发布日记，杂文，所见所想
> * 撰写发布技术文稿（代码支持）
> * 撰写发布学术论文（LaTeX 公式支持）

![cmd-markdown-logo](https://www.zybuluo.com/static/img/logo.png)

除了您现在看到的这个 Cmd Markdown 在线版本，您还可以前往以下网址下载：

### [Windows/Mac/Linux 全平台客户端](https://www.zybuluo.com/cmd/)

> 请保留此份 Cmd Markdown 的欢迎稿兼使用说明，如需撰写新稿件，点击顶部工具栏右侧的 <i class="icon-file"></i> **新文稿** 或者使用快捷键 `Ctrl+Alt+N`。

------

## 什么是 Markdown

Markdown 是一种方便记忆、书写的纯文本标记语言，用户可以使用这些标记符号以最小的输入代价生成极富表现力的文档：譬如您正在阅读的这份文档。它使用简单的符号标记不同的标题，分割不同的段落，**粗体** 或者 *斜体* 某些文字，更棒的是，它还可以

### 1. 制作一份待办事宜 [Todo 列表](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#13-待办事宜-todo-列表)

- [ ] 支持以 PDF 格式导出文稿
- [ ] 改进 Cmd 渲染算法，使用局部渲染技术提高渲染效率
- [x] 新增 Todo 列表功能
- [x] 修复 LaTex 公式渲染问题
- [x] 新增 LaTex 公式编号功能

### 2. 书写一个质能守恒公式[^LaTeX]

$$E=mc^2$$

### 3. 高亮一段代码[^code]

```python
@requires_authorization
class SomeClass:
    pass

if __name__ == '__main__':
    # A comment
    print 'hello world'
```

### 4. 高效绘制 [流程图](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#7-流程图)

```flow
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```

### 5. 高效绘制 [序列图](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#8-序列图)

```seq
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

### 6. 高效绘制 [甘特图](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#9-甘特图)

```gantt
    title 项目开发流程
    section 项目确定
        需求分析       :a1, 2016-06-22, 3d
        可行性报告     :after a1, 5d
        概念验证       : 5d
    section 项目实施
        概要设计      :2016-07-05  , 5d
        详细设计      :2016-07-08, 10d
        编码          :2016-07-15, 10d
        测试          :2016-07-22, 5d
    section 发布验收
        发布: 2d
        验收: 3d
```

### 7. 绘制表格

| 项目   |   价格 | 数量  |
| ------ | -----: | :---: |
| 计算机 | \$1600 |   5   |
| 手机   |   \$12 |  12   |
| 管线   |    \$1 |  234  |

### 8. 更详细语法说明

想要查看更详细的语法说明，可以参考我们准备的 [Cmd Markdown 简明语法手册][1]，进阶用户可以参考 [Cmd Markdown 高阶语法手册][2] 了解更多高级功能。

总而言之，不同于其它 *所见即所得* 的编辑器：你只需使用键盘专注于书写文本内容，就可以生成印刷级的排版格式，省却在键盘和工具栏之间来回切换，调整内容和格式的麻烦。**Markdown 在流畅的书写和印刷级的阅读体验之间找到了平衡。** 目前它已经成为世界上最大的技术分享网站 GitHub 和 技术问答网站 StackOverFlow 的御用书写格式。

---

## 什么是 Cmd Markdown

您可以使用很多工具书写 Markdown，但是 Cmd Markdown 是这个星球上我们已知的、最好的 Markdown 工具——没有之一 ：）因为深信文字的力量，所以我们和你一样，对流畅书写，分享思想和知识，以及阅读体验有极致的追求，我们把对于这些诉求的回应整合在 Cmd Markdown，并且一次，两次，三次，乃至无数次地提升这个工具的体验，最终将它演化成一个 **编辑/发布/阅读** Markdown 的在线平台——您可以在任何地方，任何系统/设备上管理这里的文字。

### 1. 实时同步预览

我们将 Cmd Markdown 的主界面一分为二，左边为**编辑区**，右边为**预览区**，在编辑区的操作会实时地渲染到预览区方便查看最终的版面效果，并且如果你在其中一个区拖动滚动条，我们有一个巧妙的算法把另一个区的滚动条同步到等价的位置，超酷！

### 2. 编辑工具栏

也许您还是一个 Markdown 语法的新手，在您完全熟悉它之前，我们在 **编辑区** 的顶部放置了一个如下图所示的工具栏，您可以使用鼠标在工具栏上调整格式，不过我们仍旧鼓励你使用键盘标记格式，提高书写的流畅度。

![tool-editor](https://www.zybuluo.com/static/img/toolbar-editor.png)

### 3. 编辑模式

完全心无旁骛的方式编辑文字：点击 **编辑工具栏** 最右侧的拉伸按钮或者按下 `Ctrl + M`，将 Cmd Markdown 切换到独立的编辑模式，这是一个极度简洁的写作环境，所有可能会引起分心的元素都已经被挪除，超清爽！

### 4. 实时的云端文稿

为了保障数据安全，Cmd Markdown 会将您每一次击键的内容保存至云端，同时在 **编辑工具栏** 的最右侧提示 `已保存` 的字样。无需担心浏览器崩溃，机器掉电或者地震，海啸——在编辑的过程中随时关闭浏览器或者机器，下一次回到 Cmd Markdown 的时候继续写作。

### 5. 离线模式

在网络环境不稳定的情况下记录文字一样很安全！在您写作的时候，如果电脑突然失去网络连接，Cmd Markdown 会智能切换至离线模式，将您后续键入的文字保存在本地，直到网络恢复再将他们传送至云端，即使在网络恢复前关闭浏览器或者电脑，一样没有问题，等到下次开启 Cmd Markdown 的时候，她会提醒您将离线保存的文字传送至云端。简而言之，我们尽最大的努力保障您文字的安全。

### 6. 管理工具栏

为了便于管理您的文稿，在 **预览区** 的顶部放置了如下所示的 **管理工具栏**：

![tool-manager](https://www.zybuluo.com/static/img/toolbar-manager.jpg)

通过管理工具栏可以：

<i class="icon-share"></i> 发布：将当前的文稿生成固定链接，在网络上发布，分享
<i class="icon-file"></i> 新建：开始撰写一篇新的文稿
<i class="icon-trash"></i> 删除：删除当前的文稿
<i class="icon-cloud"></i> 导出：将当前的文稿转化为 Markdown 文本或者 Html 格式，并导出到本地
<i class="icon-reorder"></i> 列表：所有新增和过往的文稿都可以在这里查看、操作
<i class="icon-pencil"></i> 模式：切换 普通/Vim/Emacs 编辑模式

### 7. 阅读工具栏

![tool-manager](https://www.zybuluo.com/static/img/toolbar-reader.jpg)

通过 **预览区** 右上角的 **阅读工具栏**，可以查看当前文稿的目录并增强阅读体验。

工具栏上的五个图标依次为：

<i class="icon-list"></i> 目录：快速导航当前文稿的目录结构以跳转到感兴趣的段落
<i class="icon-chevron-sign-left"></i> 视图：互换左边编辑区和右边预览区的位置
<i class="icon-adjust"></i> 主题：内置了黑白两种模式的主题，试试 **黑色主题**，超炫！
<i class="icon-desktop"></i> 阅读：心无旁骛的阅读模式提供超一流的阅读体验
<i class="icon-fullscreen"></i> 全屏：简洁，简洁，再简洁，一个完全沉浸式的写作和阅读环境

### 8. 阅读模式

在 **阅读工具栏** 点击 <i class="icon-desktop"></i> 或者按下 `Ctrl+Alt+M` 随即进入独立的阅读模式界面，我们在版面渲染上的每一个细节：字体，字号，行间距，前背景色都倾注了大量的时间，努力提升阅读的体验和品质。

### 9. 标签、分类和搜索

在编辑区任意行首位置输入以下格式的文字可以标签当前文档：

标签： 未分类

标签以后的文稿在【文件列表】（Ctrl+Alt+F）里会按照标签分类，用户可以同时使用键盘或者鼠标浏览查看，或者在【文件列表】的搜索文本框内搜索标题关键字过滤文稿，如下图所示：

![file-list](https://www.zybuluo.com/static/img/file-list.png)

### 10. 文稿发布和分享

在您使用 Cmd Markdown 记录，创作，整理，阅读文稿的同时，我们不仅希望它是一个有力的工具，更希望您的思想和知识通过这个平台，连同优质的阅读体验，将他们分享给有相同志趣的人，进而鼓励更多的人来到这里记录分享他们的思想和知识，尝试点击 <i class="icon-share"></i> (Ctrl+Alt+P) 发布这份文档给好友吧！

------

再一次感谢您花费时间阅读这份欢迎稿，点击 <i class="icon-file"></i> (Ctrl+Alt+N) 开始撰写新的文稿吧！祝您在这里记录、阅读、分享愉快！

作者 [@ghosert][3]     
2016 年 07月 07日    

[^LaTeX]: 支持 **LaTeX** 编辑显示支持，例如：$\sum_{i=1}^n a_i=0$， 访问 [MathJax][4] 参考更多使用方法。

[^code]: 代码高亮功能支持包括 Java, Python, JavaScript 在内的，**四十一**种主流编程语言。

[1]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown
[2]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#cmd-markdown-高阶语法手册
[3]: http://weibo.com/ghosert
[4]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference

