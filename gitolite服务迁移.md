# gitolite服务迁移

## 新服务器搭建gitolite服务
参考：https://github.com/huhongda/blog/blob/master/gitolite%E6%90%AD%E5%BB%BAgit%E6%9C%8D%E5%8A%A1%E5%99%A8.md

## 迁移数据

<pre>
# 切换到git用户
su - git

# 使用scp命令直接把老服务器上的版本库拷贝过来：
scp -r user@host:/home/git/repositories ~/
     
      
# 把gitolite的配置文件和用户公钥都拷贝过来：
scp -r user@host:/home/git/.gitolite/conf/gitolite.conf ~/.gitolite/conf/
scp -r user@host:/home/git/.gitolite/keydir/ ~/.gitolite/
$HOME/bin/gitolite setup -pk ~/.gitolite/keydir/admin.pub
</pre>

## 在新服务器添加用户权限

使用gitolite-admin添加一个新用户即可