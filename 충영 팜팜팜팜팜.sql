-- ROOM 번호와 회원 수
SELECT *
FROM (SELECT ROOM_NO, COUNT(MEMBER_NO) AS MEMBER_COUNT
			 FROM CHAT2_ENTER
			 GROUP BY ROOM_NO)
LEFT JOIN(
-- 내가 읽지 않은 채팅의 개수
SELECT ROOM_NO, (SELECT COUNT(CHAT_NO) 
				 FROM CHAT2 C2
				 WHERE C1.ROOM_NO = C2.ROOM_NO
				 AND CHAT_NO > (SELECT LAST_READ_CHAT_NO
				 				FROM CHAT2_ENTER C3
				 				WHERE MEMBER_NO = 5
				 				AND C1.ROOM_NO = C3.ROOM_NO
				 				AND ENTER_STATUS = 'Y')) AS UNREAD_CHAT_COUNT
FROM CHAT2 C1
GROUP BY ROOM_NO) USING(ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, C.CHAT_NO, C.CHAT_CONTENT AS LAST_CHAT_CONTENT, 
      CASE WHEN TO_CHAR(C.CHAT_TIME, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD') 
		   THEN TO_CHAR(C.CHAT_TIME, 'AM HH"시" MI"분"')
		   ELSE TO_CHAR(C.CHAT_TIME, 'YYYY-MM-DD')
   	  END LAST_CHAT_TIME, 
      C.CHAT_TYPE AS LAST_CHAT_TYPE
      FROM CHAT2 C
      JOIN (SELECT MAX(CHAT_NO) AS LAST_CHAT_NO
            FROM CHAT2
            GROUP BY ROOM_NO) C_SUB ON (C_SUB.LAST_CHAT_NO = C.CHAT_NO)
	  WHERE (C.CHAT_TYPE = 'T' OR C.CHAT_TYPE = 'I') ) USING(ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, ROOM_NAME, CR.ROOM_TYPE,
   		     CASE WHEN ROOM_TYPE > 0 THEN (SELECT POST_TITLE 
   		 							       FROM POST P 
   		 							       WHERE CR.ROOM_TYPE=P.POST_NO)
   		     ELSE NULL END POST_TITLE,
   		     CASE WHEN ROOM_TYPE > 0 THEN (SELECT POST_IMG_ADDRESS 
   						    	 	       FROM POST_IMG PIMG
   						    	 	       WHERE POST_IMG_ORDER = 0 AND CR.ROOM_TYPE=PIMG.POST_NO)
   		    ELSE NULL END THUMBNAIL_IMG 
      FROM CHAT2_ROOM CR) USING(ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, MEMBER_NO, ENTER_NO, ENTER_STATUS
  		   FROM CHAT2_ENTER
  		   WHERE ENTER_STATUS = 'Y' OR ENTER_STATUS = 'W') USING(ROOM_NO)
WHERE MEMBER_NO = 5
ORDER BY CHAT_NO DESC NULLS LAST;


	     
---------------------------------------------------------------------------------------------------
SELECT *
FROM (SELECT ROOM_NO, COUNT(MEMBER_NO) AS MEMBER_COUNT
			 FROM CHAT2_ENTER
			 GROUP BY ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, C.CHAT_NO, C.CHAT_CONTENT AS LAST_CHAT_CONTENT, 
      CASE WHEN TO_CHAR(C.CHAT_TIME, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD') 
		   THEN TO_CHAR(C.CHAT_TIME, 'AM HH"시" MI"분"')
		   ELSE TO_CHAR(C.CHAT_TIME, 'YYYY-MM-DD')
   	  END LAST_CHAT_TIME, 
      C.CHAT_TYPE AS LAST_CHAT_TYPE,
      (SELECT COUNT(CHAT_NO) 
				 FROM CHAT2 C2
				 WHERE C.ROOM_NO = C2.ROOM_NO
				 AND CHAT_NO > (SELECT LAST_READ_CHAT_NO
				 				FROM CHAT2_ENTER C3
				 				----------------------------
				 				WHERE MEMBER_NO = 110
				 				----------------------------
				 				AND C.ROOM_NO = C3.ROOM_NO
				 				AND ENTER_STATUS = 'Y')) AS UNREAD_CHAT_COUNT
      FROM CHAT2 C
      JOIN (SELECT MAX(CHAT_NO) AS LAST_CHAT_NO
            FROM CHAT2
            GROUP BY ROOM_NO) C_SUB ON (C_SUB.LAST_CHAT_NO = C.CHAT_NO)
	  WHERE (C.CHAT_TYPE = 'T' OR C.CHAT_TYPE = 'I') ) USING(ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, ROOM_NAME, CR.ROOM_TYPE,
   		     CASE WHEN ROOM_TYPE > 0 THEN (SELECT POST_TITLE 
   		 							       FROM POST P 
   		 							       WHERE CR.ROOM_TYPE=P.POST_NO)
   		     ELSE NULL END POST_TITLE,
   		     CASE WHEN ROOM_TYPE > 0 THEN (SELECT POST_IMG_ADDRESS 
   						    	 	       FROM POST_IMG PIMG
   						    	 	       WHERE POST_IMG_ORDER = 0 AND CR.ROOM_TYPE=PIMG.POST_NO)
   		    ELSE NULL END THUMBNAIL_IMG 
      FROM CHAT2_ROOM CR) USING(ROOM_NO)
------------------
LEFT JOIN (SELECT ROOM_NO, MEMBER_NO, ENTER_NO, ENTER_STATUS, INITIAL_CHAT_NO
  		   FROM CHAT2_ENTER
  		   WHERE ENTER_STATUS = 'Y' OR ENTER_STATUS = 'W') USING(ROOM_NO)
  		   -----------------
WHERE MEMBER_NO = 110
			-----------------
ORDER BY CHAT_NO DESC NULLS LAST;


SELECT * FROM CHAT2;

CREATE TABLE "EMOTICON_CATEGORY"(
	EMOTICON_CATEGORY_NO NUMBER PRIMARY KEY NOT NULL,
	EMOTICON_CATEGORY_NAME VARCHAR2(60) NOT NULL
);


CREATE TABLE "EMOTICON"(
	EMOTICON_NO NUMBER PRIMARY KEY NOT NULL,
	EMOTICON_CATEGORY_NO NUMBER NOT NULL REFERENCES EMOTICON_CATEGORY(EMOTICON_CATEGORY_NO),
	EMOTICON_NAME VARCHAR2(300) NOT NULL
)

COMMIT;

SELECT * FROM NOTIFY_type;

INSERT INTO EMOTICON_CATEGORY 
VALUES(1, 'farmfarmDoodle');

INSERT INTO EMOTICON
VALUES(11, 1, 'doodle11.png');

ROLLBACK;
	SELECT * FROM EMOTICON
		WHERE EMOTICON_CATEGORY_NO = #{emoticonCategoryNO}







		SELECT ROOM_NO, CHAT_NO, CHAT_TYPE, CHAT_CONTENT, CHAT_TIME, READ_COUNT,
			   MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG,
	       	   CASE WHEN CHAT_TYPE='I' THEN (SELECT CHAT_IMG_PATH FROM CHAT2_IMG SUB WHERE MAIN.CHAT_NO = SUB.CHAT_NO)
	           ELSE NULL END CHAT_IMG_PATH
		FROM CHAT2 MAIN
		LEFT JOIN MEMBER USING(MEMBER_NO)
		WHERE ROOM_NO = 70
		AND (CHAT_TYPE = 'T' OR CHAT_TYPE = 'I' OR CHAT_TYPE = 'E') 
		AND CHAT_NO > (SELECT INITIAL_CHAT_NO 
					   FROM CHAT2_ENTER 
					   WHERE ROOM_NO = 70
					   AND MEMBER_NO = 5
					   AND ENTER_STATUS = 'Y')
		AND CHAT_TIME > TRUNC(SYSDATE, 'dd') - 14
		
		
		
		ORDER BY CHAT_NO;

		
		SELECT * FROM "ORDER";
		
			 	SELECT NOTIFY_NO, NOTIFY_TYPE_NO, NOTIFY_CONTENT, QUICK_LINK, NOTIFY_STATUS,
	 		   CASE WHEN TO_CHAR(NOTIFY_DATE, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD') THEN TO_CHAR(NOTIFY_DATE, 'AM HH"시" MI"분"')
	 		   ELSE TO_CHAR(NOTIFY_DATE, 'YYYY-MM-DD') END NOTIFY_DATE,
	 	       (SELECT NOTIFY_TITLE FROM NOTIFY_TYPE ALAT WHERE ALAT.NOTIFY_TYPE_NO = ALA.NOTIFY_TYPE_NO) AS NOTIFY_TITLE 
	 	FROM NOTIFY ALA
	 	WHERE MEMBER_NO = 5
	 	AND NOTIFY_DATE > TRUNC(SYSDATE, 'dd') - 30
	 	AND NOTIFY_STATUS != -1
	 	ORDER BY NOTIFY_NO DESC;
	 	
	 	SELECT * FROM
	 	(SELECT ORDER_NO, PRODUCT_NO,
	 		   (SELECT MEMBER_NO FROM "ORDER" O WHERE OP.ORDER_NO = O.ORDER_NO) AS MEMBER_NO,
	 		   (SELECT PRODUCT_NAME FROM "PRODUCT" P WHERE OP.PRODUCT_NO = P.PRODUCT_NO) AS PRODUCT_NAME,
	 		   (SELECT COUNT(*) FROM "ORDER_PRODUCT" WHERE ORDER_NO = 84) AS ORDER_COUNT
	 	FROM ORDER_PRODUCT OP
	 	WHERE ORDER_NO = 84
	 	ORDER BY PRODUCT_NO)
	 	WHERE ROWNUM = 1;
	 
	 SELECT * FROM "ORDER"
	 	
	 SELECT * FROM PRODUCT;
	 
	 
	 COMMIT;
	 SELECT * FROM NOTIFY_TYPE;
	 INSERT INTO NOTIFY_TYPE VALUES(303, '주문이 취소되었어요');