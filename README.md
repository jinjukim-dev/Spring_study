### Spring_study

mybatis 설정

root-context.xml DB설정
```
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="driverClassName" value="net.sf.log4jdbc.sql.jdbcapi.DriverSpy"></property>
		<property name="url" value="jdbc:log4jdbc:mysql://localhost:3306/springbasic?useUnicode=true&amp;characterEncoding=utf8"></property>
		<property name="url" value="jdbc:mysql://localhost:3306/springbasic?useUnicode=true&amp;characterEncoding=utf8"></property>-->
		<property name="username" value="jjkim"></property>
		<property name="password" value="1234"></property>
</bean>

<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"/>
		<property name="configLocation"  value="classpath:mybatis-config.xml"/>
		<property name="mapperLocations" value="classpath:mapper/*Mapper.xml"/>
	</bean>

<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
		<constructor-arg ref="sqlSessionFactory"/>
</bean>

```

mybatis-config.xml
```
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <configuration>
      <typeAliases>
          <typeAlias alias="BoardDto" type="com.fastcampus.ch4.domain.BoardDto"/>
      </typeAliases>
  </configuration>
```

----------------

controller -> service -> Dao -> mybatis mapper.xml DB 접근

/domain/BoardDto.java
```
@Data
public class BoardDto {
    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private int view_cnt;
    private int comment_cnt;  // 덧글 갯수
    private Date reg_date;
 }
```

/controller/BoardController.java
```
@Controller
    @GetMapping("/list")
    public String list(SearchCondition sc, Model m, HttpServletRequest request) {
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동

        try {

            List<BoardDto> list = boardService.getList();
            m.addAttribute("list", list);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
    }
```

/service/BoardService.java
```
public interface BoardService {
    List<BoardDto> getList() throws Exception;
}
```

/service/BoardServiceImpl.java
```
@Service
public class BoardServiceImpl implements BoardService {

    private final BoardDao boardDao;
    
    public BoardServiceImpl(BoardDao boardDao) {
		this.boardDao = boardDao;
	  }

    @Override
    public List<BoardDto> getList() throws Exception{
        return boardDao.selectAll();
    }
 }
```

/dao/boardDao.java
```
public interface BoardDao {
  List<BoardDto> selectAll() throws Exception;
}
```

/dao/boardDaoImpl.java
```
@Repository
public class BoardDaoImpl implements BoardDao {
    @Autowired
    SqlSession session;
    String namespace = "com.fastcampus.ch4.dao.BoardMapper.";
    
    @Override
    public List<BoardDto> selectAll() throws Exception{
        return session.selectList(namespace+"selectAll");
    }

```

src/main/resources/mapper/
boardMapper.xml
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.fastcampus.ch4.dao.BoardMapper">

    <!-- 정렬 등록일 내림차순, 게시글 번호 내림차순 -->
    <select id="selectAll" resultType="BoardDto">
        select bno, title, content, writer, view_cnt, comment_cnt, reg_date, up_date
        from board
        order by reg_date desc, bno desc
    </select>
    
</mapper>
```





