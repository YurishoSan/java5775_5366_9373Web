<%@page import="entities.PatientAllergy"%>
<%@page import="entities.Allergy"%>
<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Patient"%>
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
					<td style="text-align: center;"><select name="patientID"
						style="width: 100%">
							<%
								ArrayList<Patient> patients = BackendFactory.getInstance()
										.getPatientList();
								for (Patient patient : patients)
								{
							%>
							<option value=<%=patient.getPatientID()%>><%=patient.getPatientFirstName() + " "
						+ patient.getPatientLastName()%></option>
							<%
								}
							%>
					</select></td>
					<td style="text-align: right; width: 100px">פציינט</td>
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
			long patientID;
			long allergyID;

			try
			{
				patientID = Long.valueOf(request.getParameter("patientID"));
				allergyID = Long.valueOf(request.getParameter("allergyID"));

				PatientAllergy patientAllergy = new PatientAllergy(
						patientID, allergyID);
				if (patientAllergy != null)
				{
					BackendFactory.getInstance().addPatientAllergy(
							patientAllergy);
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