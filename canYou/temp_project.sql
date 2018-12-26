create table tproject(
    tprojectNo number primary key,
    memberNo number not null,
    categoryNo number,
    subCategoryNo number,
    tprojectName varchar2(30),
    tprojectCost number,
    tprojectStartDate date,
    tprojectEndDate date,
    tprojectMainImage varchar2(300),
    tprojectStory clob,
    tprojectDate date,
    constraint tmemberNo_fk foreign key(memberNo) references member(memberNo),
    constraint categoryNo_fk foreign key(categoryNo) references category(categoryNo),
    constraint subCategoryNo_fk foreign key(subCategoryNo) references subCategory(subCategoryNo)
);

create table tproduct(
    tproductNo number primary key,
    tproductName varchar2(50),
    tproductCnt number,
    tproductInfo clob,
    tproductCost number,
    tprojectNo number,
    constraint tprojectNo_fk foreign key(tprojectNo) references tproject(tprojectNo)
);


create sequence tproduct_seq
increment by 1
start with 1;

create sequence tproject_seq
increment by 1
start with 1;