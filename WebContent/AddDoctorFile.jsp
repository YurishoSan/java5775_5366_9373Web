<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Doctor"%>
<%@page import="entities.enums.Specialization"%>
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
		<h1 style="text-align: center;">הוסף דוקטור</h1>

		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><input name="doctorID"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">ת.ז</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="doctorFirstName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם פרטי</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="doctorLastName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם משפחה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select name="doctorGender"
						style="width: 100%" type="text"><option value="MALE">זכר</option>
							<option value="FEMALE">נקבה</option></select></td>
					<td style="text-align: right; width: 100px">מין</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="doctorDoB"
						style="width: 100%" type="date" /></td>
					<td style="text-align: right; width: 100px">תאריך לידה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input
						name="doctorEmailAddress" style="width: 100%" type="email" /></td>
					<td style="text-align: right; width: 100px">אי-מייל</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="doctorDoJ"
						style="width: 100%" type="date" /></td>
					<td style="text-align: right; width: 100px">תאריך הצתרפות</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="doctorSallary"
						style="width: 100%" type="number" /></td>
					<td style="text-align: right; width: 100px">משכורת</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input
						name="doctorPhoneNumber" style="width: 100%" type="tel" /></td>
					<td style="text-align: right; width: 100px">טלפון</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select
						name="doctorSpecialization" style="width: 100%" type="text"><option
								value="FAMILY">משפחה</option>
							<option value="DENTIST">שיניים</option>
							<option value="SURGEY">מנתח</option></select></td>
					<td style="text-align: right; width: 100px">התמחות</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
		<%
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			Long doctorID;
			String doctorFirstName;
			String doctorLastName;
			Gender doctorGender;
			Date doctorDoB;
			String doctorEmailAddress;
			Date doctorDoJ;
			Float doctorSallary;
			String doctorPhoneNumber;
			Specialization doctorSpecialization;

			doctorFirstName = request.getParameter("doctorFirstName");
			doctorLastName = request.getParameter("doctorLastName");
			doctorEmailAddress = request.getParameter("doctorEmailAddress");
			doctorPhoneNumber = request.getParameter("doctorPhoneNumber");

			if (doctorFirstName != null && doctorFirstName != ""
					&& doctorLastName != null && doctorLastName != ""
					&& doctorEmailAddress != null && doctorEmailAddress != ""
					&& doctorPhoneNumber != null && doctorPhoneNumber != "")
			{
				try
				{
					doctorID = Long.valueOf(request.getParameter("doctorID"));
					doctorSallary = Float.valueOf(request
							.getParameter("doctorSallary"));

					doctorDoB = format.parse(request.getParameter("doctorDoB"));
					doctorDoJ = format.parse(request.getParameter("doctorDoJ"));

					doctorGender = Gender.valueOf(request
							.getParameter("doctorGender"));
					doctorSpecialization = Specialization.valueOf(request
							.getParameter("doctorSpecialization"));

					Doctor doctor = new Doctor(doctorID, doctorFirstName,
							doctorLastName, doctorGender, doctorDoB, doctorDoJ,
							doctorEmailAddress, doctorSallary,
							doctorPhoneNumber, doctorSpecialization);
					BackendFactory.getInstance().addDoctor(doctor);
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
