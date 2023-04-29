<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Excel导入</title>
</head>
<style>
    #file-value{
        display: none !important;
    }
</style>
<body>

<font>请选择上传的文件</font>
<form id="file-form" method="post" action="/fourtest_war_exploded/upload">
    <div>
        <input type="text" id="file-value" name="file-value" />
        <input type="file" id="file" name="file" accept=".xlsx, .xls" />
        <br/><br/>
        <button id="btn" type="button">提交</button>
    </div>
</form>
<br/>

<script src="./js/xlsx.core.min.js"></script>
<script type="text/javascript">
    window.addEventListener("load", () => {
        // 获取DOM元素
        const fileForm = document.getElementById("file-form");
        const valueInput = document.getElementById("file-value");
        const fileInput = document.getElementById("file");
        const btn = document.getElementById("btn");

        //定义变量，用来存储excel的数据集，以及input(file)选择的文件
        let users = [];
        let file = null;
        let type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //监听事件
        btn.addEventListener("click", () => {
            if (file == null){
                reset();
                return;
            }else {
                if(users.length > 0){
                    let usersString = JSON.stringify(users);
                    valueInput.value = usersString;
                    fileForm.submit();
                }
            }
        });

        fileInput.addEventListener("change", fe => {
            console.log(fe.target.files[0]);
            if(fe.target.files[0] != null){
                let fileType = fe.target.files[0].type;
                if (fileType == type){
                    file = fe.target.files[0];
                    // 用filereader对象读取数据
                    let fileReader = new FileReader();
                    fileReader.addEventListener("load", re => {
                        try {
                            // 获取数据对象
                            var data = re.target.result;
                            // 获取workbook对象
                            var workbook = XLSX.read(data, {
                                type: "binary"
                            });
                        }catch (err){
                            reset();
                            console.error(err);
                            alert("文件格式错误!");
                        }
                        console.log(workbook);
                        let fromTo = "";
                        for(var sheet in workbook.Sheets){
                            if(workbook.Sheets.hasOwnProperty(sheet)){
                                fromTo = workbook.Sheets[sheet]["!ref"];
                                if (fromTo != undefined){
                                    users = XLSX.utils.sheet_to_json(workbook.Sheets[sheet]);
                                }
                            }
                        }
                        for (var i = 0; i < users.length; i++){
                            let tr = document.createElement("tr");
                            tr.innerHTML = "<td>"+users[i].id+"</td>" +
                            "<td>"+users[i].name+"</td>" + "<td>"+users[i].password+"</td>";
                            table.appendChild(tr);
                        }
                    });
                    fileReader.readAsBinaryString(file);
                }
            }
        });

        function reset(){
            users = [];
            file = null;
            fileInput.value = "";
        }

    });
</script>
</body>
</html>