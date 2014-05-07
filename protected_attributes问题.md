# protected_attributes问题

### 问题

将rails3 -> rails4 遇见这样的问题：
<pre>
Failure/Error: let(:project) { create(:project) }
     NoMethodError:
       undefined method `[]' for nil:NilClass
</pre>

<pre>
$ Production.new
=> (Object doesn't support #inspect)
</pre>

查看源码得知：protected_attributes  1.0.3 版本 将ActiveRecord::Base 的initialize方式给重载了

https://github.com/rails/protected_attributes/commit/22e1953ae68850bafbb0c5939b45922d89907d67


### 解决

升级protected_attributes, protected_attributes的1.0.5已经解决了这个bug了



