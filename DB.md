## SQLite 사용법

참고한 링크

##### [SQLite JDBC](https://velog.io/@zihoo/SQLite-JDBC)
##### [SQLite JSP 사용 시 참고 사항](https://blog.naver.com/haengro/40061270062)

### 데이터베이스 구조
#### member
| 키        | 타입          | 조건                          |
|----------|-------------|-----------------------------|
| ID       | INTERGER    | PRIMARY KEY, AUTO_INCREMENT |
| NAME     | VARCHAR(10) | NOT NULL                    |
| EMAIL    | VARCHAR(30) | NOT NULL                    |
| PASSWORD | VARCHAR(30) | NOT NULL                    |

#### todo
| 키        | 타입         | 조건                     |
|----------|------------|------------------------|
| NAME     | VARCHAR(20) | NOT NULL               |
| STATE    | VARCHAR(8) | NOT NULL               |
| OWNER_ID | INTEGER    | FOREIGN KEY member(ID) |

### JDBC 실행하기
```java
Class.forName("org.sqlite.JDBC");
Connection conn = DriverManager.getConnection("jdbc:sqlite:[작업 파일 경로]/identifier.sqlite");
Statement stat = conn.createStatement();

ResultSet rs = stat.executeQuery("select * from member;");
while (rs.next()) {
    out.println("name = " + rs.getString("name"));
    out.println("<BR>");
}
rs.close();
conn.close();
```