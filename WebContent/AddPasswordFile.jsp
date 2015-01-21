<%@page import="entities.Password"%>
<%@page import="entities.enums.Permit"%>
<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Doctor"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<!doctype html>
<html>
<head>
<title>הוסף סיסמה</title>
</head>
<body>
	<form>
		<h1 style="text-align: center;">הוסף סיסמה</h1>

		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><select name="passwordUserID"
						style="width: 100%">
							<%
								ArrayList<Doctor> doctors = BackendFactory.getInstance()
										.getDoctorList();
								for (Doctor doctor : doctors)
								{
							%>
							<option value=<%=doctor.getDoctorID()%>><%=doctor.getDoctorFirstName() + " "
						+ doctor.getDoctorLastName()%></option>
							<%
								}
							%>

					</select></td>
					<td style="text-align: right; width: 100px">משתמש</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input name="passwordWord"
						style="width: 100%" type="password" /></td>
					<td style="text-align: right; width: 100px">סיסמה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><select name="PasswordPermit"
						style="width: 100%"><option value="DENIED">חסום</option>
							<option value="DOCTOR">דוקטור</option></select></td>
					<td style="text-align: right; width: 100px">דרגת גישה</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
		<%
			String passwordWord;
			Permit PasswordPermit;
			long passwordUserID;

			try
			{
				passwordWord = request.getParameter("passwordWord");
				passwordUserID = Long.valueOf(request
						.getParameter("passwordUserID"));
				PasswordPermit = Permit.valueOf(request
						.getParameter("PasswordPermit"));

				if (passwordWord != null && passwordWord != "")
				{
					Password password = new Password(passwordUserID, passwordWord, PasswordPermit);
					if (password != null)
					{
						BackendFactory.getInstance().addPassword(password);
						response.sendRedirect("index.html");
						out.print("good");
					}
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
