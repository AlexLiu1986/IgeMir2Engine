unit Share;

interface
const
  sPlugName        = '【IGE科技 IP查询插件】(2008/11/30)';
  sStartLoadPlug   = '加载【IGE科技 IP查询插件】成功';
  sUnLoadPlug      = '卸载【IGE科技 IP查询插件】成功';

  sIPFileName      ='.\IpList.db';
//设置本插件接管那些函数(数值设置0，1)
  HookDeCodeText    = 0; //文本配置信息解码函数
  HookSearchIPLocal = 1; //IP所在地查询函数


implementation

end.
