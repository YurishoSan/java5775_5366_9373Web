<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Medicine"%>
<%@page import="entities.enums.MedicineType"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>הוסף תרופה</title>
</head>
<body>
	<form>
		<h1 style="text-align: center;">הוסף תרופה</h1>

		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><input name="medicineName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם התרופה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><textarea cols="5"
							name="medicineIngredients" style="width: 100%"></textarea></td>
					<td style="text-align: right; width: 100px">רכיבים</td>
				</tr>
				<tr>
					<td style="text-align: center;"><textarea cols="5"
							name="medicineActiveIngredients" style="width: 100%"></textarea></td>
					<td style="text-align: right; width: 100px">רכיבים פעילים</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select name="medicineType"
						style="width: 100%"><option value="PILL_TABLET">טבלית
								גלולות</option>
							<option value="PILL_BOTTLE">קופסת גלולות</option>
							<option value="LIQUID_BOTTLE">בקבוק נוזל</option></select></td>
					<td style="text-align: right; width: 100px">סוג התרופה</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
		<%
			String medicineName = request.getParameter("medicineName");
			String medicineIngredients = request
					.getParameter("medicineIngredients");
			String medicineActiveIngredients = request
					.getParameter("medicineActiveIngredients");
			MedicineType medicineType;

			if (medicineName != null && medicineName != ""
					&& medicineIngredients != null && medicineIngredients != ""
					&& medicineActiveIngredients != null
					&& medicineActiveIngredients != "")
			{
				try
				{
					medicineType = MedicineType.valueOf(request
							.getParameter("medicineType"));

					Medicine medicine = new Medicine(0, medicineName,
							medicineIngredients, medicineActiveIngredients,
							medicineType);
					BackendFactory.getInstance().addMedicine(medicine);
					response.sendRedirect("index.html");
					out.print("good");
				}
				catch (Exception e)
				{
					out.print(e.getMessage());
				}
			}
			else
			{
				out.print("נא למלא את כל השדות!");
			}
		%>
	</form>
</body>
</html>
