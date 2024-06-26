<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jiajiao.bean.Member"%>
<%@page import="com.jiajiao.bean.District"%>
<%@page import="com.jiajiao.bean.MemberOrderTeacher"%>
<%@page import="com.jiajiao.bean.Orders"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Member member = (Member) session.getAttribute("member");
	if (member == null) {
		response.sendRedirect(basePath);
		return;
	}
%>

<jsp:include page="header.jsp"></jsp:include>



<!--end一行的左-->
<div class="r_cell box_r">

	<dl class="tab_nav r_tab_nav">
		<dd>
			<a href="javascript:void(0)" class="tab_light">我的家教订单</a>
		</dd>
	</dl>
	<div class="@*tab_box*@ list_tb">
		<div>
			<table class="list_table hover_table">
				<thead>
				<tr>
					<th>订单编号</th>
					<th>授课科目</th>
					<th>授课教员</th>
					<th>发布时间</th>
					<th>预约状态</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<%
					List<Orders> orderList = (List<Orders>)request.getAttribute("orderList");
					if(orderList!=null){
						for(int i=0;i<orderList.size();i++){
							Orders order = orderList.get(i);
				%>
				<tr >
					<td>

						<%=order.getOrderCode()%>

					</td>
					<td><%=order.getCourseName() %></td>
					<td data-id="63458" class="">
											<span class="blue_link">
												<a target="_blank" href="../teacher/teacherInfoPage.action?tId=<%=order.getTeacherId() %>">
													<%=order.getTeacherName() %>
												</a>
											</span>
					</td>
					<td>
											<span class="data_2">
	                                    		<%=order.getPublicTime().substring(0,10) %>
	                                    		<p><%=order.getPublicTime().substring(10,18) %></p>
	                                		</span>
					</td>
					<td>
						<%
							int state = order.getOrderStatus();
							if(state==22){
						%>
						发布中
						<%}else if(state==23){ %>
						教员申请
						<%}else if(state==24){ %>
						授课中
						<%}else if(state==25){ %>
						已完成
						<%}else if(state==26){ %>
						订单失败
						<%}else if(state==27){ %>
						已评价
						<%}%>

					</td>
					<td>
											<span class="blue_link">
	                                    <a href="../order/orderInfo.action?oId=<%=order.getoId() %>" target="_blank" class="btndel">查看</a>
	                         	       		</span>
						<%
							if(state==25){
						%>
						<!-- 评价按钮 -->
						<span class="blue_link">
							<a href="javascript:void(0)" onclick="showCompletedOrders()">评价</a>
						</span>

						<!-- 评价弹框 -->
						<div id="evaluationModal" class="modal">
							<input type="hidden" id="oId" value="">
							<input type="hidden" id="teacherId" value="/* 教师ID */">
							<input type="hidden" id="memberId" value="/* 成员ID */">
							<label>评分:</label>
							<input type="radio" name="score" value="1"> 1
							<input type="radio" name="score" value="2"> 2
							<input type="radio" name="score" value="3"> 3
							<input type="radio" name="score" value="4"> 4
							<input type="radio" name="score" value="5"> 5
							<br>
							<label>评语:</label>
							<textarea id="evaluationContent"></textarea>
							<br>
							<button onclick="submitEvaluation()">提交评价</button>
							<button onclick="closeEvaluationModal()">取消</button>
						</div>

						<!-- 模态框背景遮罩 -->
						<div id="modalOverlay" class="overlay" onclick="closeEvaluationModal()"></div>

						<%}%>

					</td>
				</tr>
				<%
						}
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
<!--end一行-->
<style>
/* 模态框样式 */
.modal {
display: none;
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
background-color: white;
padding: 20px;
border: 1px solid #ccc;
z-index: 1000;
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
width: 300px; /* 设置弹框宽度 */
text-align: center;
}

/* 背景遮罩样式 */
.overlay {
display: none;
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;
background-color: rgba(0, 0, 0, 0.5);
z-index: 999;
}
</style>
<script>
function openEvaluationModal(oId) {
document.getElementById('oId').value = oId;
document.getElementById('evaluationModal').style.display = 'block';
document.getElementById('modalOverlay').style.display = 'block';
}
function closeEvaluationModal() {
document.getElementById('evaluationModal').style.display = 'none';
document.getElementById('modalOverlay').style.display = 'none';
}

function submitEvaluation() {
const oId = document.getElementById('oId').value;
const teacherId = document.getElementById('teacherId').value;
const memberId = document.getElementById('memberId').value;
const score = document.querySelector('input[name="score"]:checked').value;
const evaluationContent = document.getElementById('evaluationContent').value;
const evaluationTime = new Date().toISOString(); // 或者使用其他日期格式

const evaluationData = {
oId: oId,
teacherId: teacherId,
memberId: memberId,
score: score,
evaluationContent: evaluationContent,
evaluationTime: evaluationTime
};

fetch('/order/evaluation', {
method: 'POST',
headers: {
'Content-Type': 'application/json'
},
body: JSON.stringify(evaluationData)
})
.then(response => response.json())
.then(data => {
if (data.success) {
alert(data.message);
closeEvaluationModal();
} else {
alert(data.message);
}
})
.catch(error => {
console.error('Error:', error);
alert('评价提交失败，请重试');
});
}
</script>



<jsp:include page="../footer.jsp"></jsp:include>