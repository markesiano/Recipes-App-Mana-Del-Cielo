abstract class IMapper<TDTO, UOutPut> {
  UOutPut ToEntity(TDTO dto);
}
