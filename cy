<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>词语分类任务</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .word {
            display: inline-block;
            padding: 10px 15px;
            margin: 5px;
            background: #f0f0f0;
            border-radius: 5px;
            cursor: pointer;
        }
        .word.selected {
            background: #a0d8ef;
        }
        .category {
            margin-top: 20px;
            padding: 15px;
            border: 1px dashed #ccc;
            min-height: 50px;
        }
        button {
            margin-top: 20px;
            padding: 10px 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>词语分类任务</h2>
    <p>请点击词语将其选中，然后点击下方区域进行分类：</p>
    
    <div id="word-container">
        <!-- 所有词语会在这里动态生成 -->
    </div>
    
    <div>
        <button onclick="addCategory()">添加新分类</button>
        <button onclick="submitResults()">完成分类</button>
    </div>
    
    <div id="category-container">
        <!-- 分类区域会在这里动态生成 -->
    </div>
    
    <div id="result" style="margin-top: 30px; display: none;">
        <h3>你的分类结果：</h3>
        <p id="category-count"></p>
        <div id="category-details"></div>
    </div>

    <script>
        // 所有词语
        const words = [
            "苹果", "杯子", "电影", "桌子",
            "手表", "手机", "房子",
            "手提包", "名片", "肥皂",
            "网球", "头发", "汽车", "水壶",
            "温度计", "自行车", "牙刷",
            "钥匙", "泳衣", "奶酪"
        ];
        
        // 当前选中的词语
        let selectedWords = [];
        
        // 初始化词语显示
        function initWords() {
            const container = document.getElementById("word-container");
            words.forEach(word => {
                const wordElement = document.createElement("span");
                wordElement.className = "word";
                wordElement.textContent = word;
                wordElement.onclick = function() {
                    this.classList.toggle("selected");
                    const index = selectedWords.indexOf(word);
                    if (index === -1) {
                        selectedWords.push(word);
                    } else {
                        selectedWords.splice(index, 1);
                    }
                };
                container.appendChild(wordElement);
            });
        }
        
        // 添加新分类
        function addCategory() {
            if (selectedWords.length === 0) {
                alert("请先选中词语");
                return;
            }
            
            const categoryContainer = document.getElementById("category-container");
            const category = document.createElement("div");
            category.className = "category";
            category.innerHTML = `<strong>分类 ${categoryContainer.children.length + 1}:</strong> `;
            
            selectedWords.forEach(word => {
                const wordElement = document.createElement("span");
                wordElement.className = "word";
                wordElement.textContent = word;
                wordElement.style.marginRight = "5px";
                category.appendChild(wordElement);
                
                // 从总列表中移除已分类词语
                const words = document.querySelectorAll("#word-container .word");
                words.forEach(el => {
                    if (el.textContent === word) {
                        el.style.display = "none";
                    }
                });
            });
            
            categoryContainer.appendChild(category);
            selectedWords = [];
        }
        
        // 提交结果
        function submitResults() {
            const categoryCount = document.querySelectorAll("#category-container .category").length;
            const remainingWords = document.querySelectorAll("#word-container .word:not([style*='display: none'])").length;
            
            if (remainingWords > 0) {
                if (!confirm(`还有 ${remainingWords} 个词语未分类，确定提交吗？`)) {
                    return;
                }
            }
            
            document.getElementById("category-count").textContent = `共分为 ${categoryCount} 类`;
            
            const details = document.getElementById("category-details");
            details.innerHTML = "";
            
            document.querySelectorAll("#category-container .category").forEach((cat, i) => {
                const p = document.createElement("p");
                p.textContent = `第 ${i+1} 类: ${cat.textContent.replace(/^分类 \d+:/, "")}`;
                details.appendChild(p);
            });
            
            document.getElementById("result").style.display = "block";
            alert("请截图此页面并上传到问卷中");
        }
        
        // 初始化
        window.onload = initWords;
    </script>
</body>
</html>
