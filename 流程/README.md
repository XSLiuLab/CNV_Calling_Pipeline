# TCGA数据CNV分析流程

* 整理数据生成CSV文件
* 批量生成pbs文件使用snp-pileup来处理
* 调用facets处理

## 生成CSV文件
    按照病人ID、normal_ID、normal_path、tumor_ID、tumor_path的顺序整理成一个列表生成CSV文件。可以使用脚本create_csv.R。注意自己数据各个ID的位置。
    
## 批量生成pbs文件
   批量生成pbs文件可以使用两种方法：
   * 用师兄写好的批量生成pbs文件的方法，只需要一个模板和相应的样本文件。
   * 用脚本create_pbs.py，改一下csv文件的位置就好了。
## 调用facets处理
这一步又分两步
* 生成R文件
* 生成*ID_facets.pbs文件调用相应的R文件提交处理
### 生成R文件
同样需要R文件的模板和前面提到的样本文件
### 生成pbs文件
这一步和上面相同但是推荐使用师兄写的生成pbs文件的方法.    