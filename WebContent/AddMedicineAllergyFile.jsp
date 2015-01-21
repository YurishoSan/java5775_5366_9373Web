<%@page import="entities.MedicineAllergy"%>
<%@page import="entities.Allergy"%>
<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Medicine"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>הוסף טיפול</title>
</head>
<body>
	<form>
		<h1 style="text-align: center;">הוסף קשר תרופה-אלרגיה</h1>

		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><select name="medicineID"
						style="width: 100%">
							<%
								ArrayList<Medicine> medicines = BackendFactory.getInstance()
										.getMedicineList();
								for (Medicine medicine : medicines)
								{
							%>
							<option value=<%=medicine.getMedicineID()%>><%=medicine.getMedicineName()%></option>
							<%
								}
							%>
					</select></td>
					<td style="text-align: right; width: 100px">תרופה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select name="allergyID"
						style="width: 100%">
							<%
								ArrayList<Allergy> allergies = BackendFactory.getInstance()
										.getAllergyList();
								for (Allergy allergy : allergies)
								{
							%>
							<option value=<%=allergy.getAllergyID()%>><%=allergy.getAllergyName()%></option>
							<%
								}
							%>
					</select></td>
					<td style="text-align: right; width: 100px">אלרגיה</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
		<%
			long medicineID;
			long allergyID;

			try
			{
				medicineID = Long.valueOf(request.getParameter("medicineID"));
				allergyID = Long.valueOf(request.getParameter("allergyID"));

				MedicineAllergy medicineAllergy = new MedicineAllergy(
						medicineID, allergyID);
				if (medicineAllergy != null)
				{
					BackendFactory.getInstance().addMedicineAllergy(
							medicineAllergy);
					response.sendRedirect("index.html");
					out.print("good");
				}
			}
			catch (Exception e)
			{
				out.print(e.getMessage());
			}
		%>
	</form>
</body>
</html>