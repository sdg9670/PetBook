<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="db.pictures.PicturesDAO"%>
<%@ page import="db.pictures.PicturesDTO"%>
<%@ page import="db.writes.WritesDAO"%>
<%@ page import="db.writes.WritesDTO"%>

<%request.setCharacterEncoding("utf-8");%>
<%
String realFolder = "";//웹 어플리케이션상의 절대 경로 저장
String saveFolder = "/upload"; //파일 업로드 폴더 지정
String encType = "utf-8"; //인코딩타입
int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
boolean check = false;
PicturesDAO pdao = new PicturesDAO();
PicturesDTO pdto = new PicturesDTO();
//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구함
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);  
int petid = -1;
WritesDTO wdto = null;
try{

	MultipartRequest upload = null;
	//파일 업로드를 수행하는 MultipartRequest 객체 생성 
	upload = new MultipartRequest(request,realFolder,maxSize,
			            encType,new DefaultFileRenamePolicy());
	   
	//<input type="file">이 아닌 모든 파라미터를 얻어냄
	Enumeration<?> params = upload.getParameterNames();
	  
	//파일 아닌 파라미터들의 값을 반복해서 얻어냄
	while(params.hasMoreElements()){
		String name = (String)params.nextElement(); //파라미터명
	    String value = upload.getParameter(name); //파라미터값  
	}

	//<input type="file">인 모든 파라미터를 얻어냄
	Enumeration<?> files = upload.getFileNames();
	   
	
	//업로드된 모든 파일의 정보를 반복해서 얻어냄
	while(files.hasMoreElements()){
	    String name = (String)files.nextElement();//파라미터이름
	    //서버에 업로드된 파일명
	    String filename = upload.getFilesystemName(name);
	    //원래 파일명
	    String original = upload.getOriginalFileName(name);
	    //업로드된 파일의 타입 - 파일 종류
	    String type = upload.getContentType(name);
	    
	    //업로드된 파일의 정보를 얻어내기 위해 File객체로 생성
	    File file = upload.getFile(name);
		if(file != null)
		{
			pdto.setPath("."  + saveFolder + "/" + filename);
			pdto = pdao.getPicture(pdao.createPictures(pdto));
			check = true;
		}
    }
	if(check == false && (upload.getParameter("content") == null || upload.getParameter("content").length() == 0))
	{
%>
<%
	String npage = new String();
	if(request.getParameter("type").equals("pet"))
		npage = "profile.jsp?petid="+pdto.getId();
	else if(request.getParameter("type").equals("index") || request.getParameter("type").equals("report"))
		npage = "index.jsp";
	%>
	<script>
		alert("내용 또는 사진을 입력하세요.");
		location.href = '<%=npage%>'
	</script>
<%
	}
	else
	{
		if(!check)
			pdto.setId(-100);
		WritesDAO wdao = new WritesDAO();
		wdto = new WritesDTO();
		wdto.setContent(upload.getParameter("content"));
		wdto.setPicture(pdto.getId());
		wdto.setId(Integer.parseInt(upload.getParameter("writeid")));
		wdao.updateWrite(wdto);
	}
	
}catch(Exception e){
	e.printStackTrace();
}
%>
<jsp:forward page="view.jsp">
	<jsp:param value="<%=wdto.getId()%>" name="last_id"/>
</jsp:forward>