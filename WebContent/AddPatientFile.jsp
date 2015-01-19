<%@page import="entities.Patient"%>
<%@page import="entities.enums.ServiceClass"%>
<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entities.enums.Gender"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>הוסף דוקטור</title>
</head>
<body>
	<form>
		<h1 style="text-align: center;">הוסף פציינט</h1>
		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><input name="patientID"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">ת.ז</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="patientFirstName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם פרטי</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="patientLastName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם משפחה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select name="patientGender"
						style="width: 100%" type="text"><option value="MALE">זכר</option>
							<option value="FEMALE">נקבה</option></select></td>
					<td style="text-align: right; width: 100px">מין</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="patientDoB"
						style="width: 100%" type="date" /></td>
					<td style="text-align: right; width: 100px">תאריך לידה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input
						name="patientEmailAddress" style="width: 100%" type="email" /></td>
					<td style="text-align: right; width: 100px">אי-מייל</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input
						name="patientPhoneNumber" style="width: 100%" type="tel" /></td>
					<td style="text-align: right; width: 100px">טלפון</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select
						name="patientServiceClass" style="width: 100%" type="text"><option
								value="REGULAR">רגיל</option>
							<option value="SILVER">כסף</option>
							<option value="GOLD">זהב</option>
							<option value="PLATINUM">פלטיניום</option>
							<option value="VIP">וי.אי.פי.</option></select></td>
					<td style="text-align: right; width: 100px">סוג כרטיס</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
	</form>
	<%
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		Long patientID;
		String patientFirstName;
		String patientLastName;
		Gender patientGender;
		Date patientDoB;
		String patientEmailAddress;
		String patientPhoneNumber;
		ServiceClass patientServiceClass;

		patientFirstName = request.getParameter("patientFirstName");
		patientLastName = request.getParameter("patientLastName");
		patientEmailAddress = request.getParameter("patientEmailAddress");
		patientPhoneNumber = request.getParameter("patientPhoneNumber");

		if (patientFirstName != null && patientFirstName != ""
				&& patientLastName != null && patientLastName != ""
				&& patientEmailAddress != null && patientEmailAddress != ""
				&& patientPhoneNumber != null && patientPhoneNumber != "")
		{
			try
			{
				patientID = Long.valueOf(request.getParameter("patientID"));

				patientDoB = format.parse(request
						.getParameter("patientDoB"));

				patientGender = Gender.valueOf(request
						.getParameter("patientGender"));
				patientServiceClass = ServiceClass.valueOf(request
						.getParameter("patientServiceClass"));

				Patient patient = new Patient(patientID, patientFirstName,
						patientLastName, patientGender, patientDoB,
						patientEmailAddress, patientServiceClass,
						patientPhoneNumber);
				BackendFactory.getInstance().addPatient(patient);
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
</body>
</html>
