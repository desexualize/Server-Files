
local cfg = {}

-- start wallet/bank values
cfg.open_wallet = 50000
-- cfg.open_bank = 5000
cfg.open_bank = 2500000

cfg.display_css = [[
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&family=Open+Sans&family=Roboto+Condensed:wght@300;400&display=swap');

    @font-face {
      font-family: 'Noto Sans JP', sans-serif;
      src:url('https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300&family=Open+Sans&display=swap');
    }
    
    .div_money{
      position: absolute;
      font-family: 'Roboto Condensed', sans-serif;
      top: 90%;
      left: 320px;
      font-weight: 100;
    
      text-align: right;
      border-radius: 15px;
    
      box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.9);
      background: rgba(0, 0, 0, 0.6);
    
      padding:5px;
      font-size: 18px;
      width: 150px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-shadow: 1.5px 1px rgb(0, 0, 0);
    }
    
    .div_bmoney{
      position: absolute;
      font-family: 'Roboto Condensed', sans-serif;
      top: 93.5%;
      left: 320px;
      font-weight: 100;
    
      text-align: right;
      border-radius: 15px;
     
      box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.9);
      background: rgba(0, 0, 0, 0.6);
    
      padding:5px;
      font-size: 18px;
      width: 150px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-shadow: 1.5px 1px rgb(0, 0, 0);
    
      }
    
    .div_money .symbol{
      position:absolute;
      content: url('https://cdn.discordapp.com/attachments/848856393012346930/866655759558377503/cash.png');
      left: 11px;
      top : 4px;
      width: 25px;
      height: 25px;
    }
    
    .div_bmoney .symbol{
      position:absolute;
      content: url('https://cdn.discordapp.com/attachments/848856393012346930/866655746460352522/bank.png');
      left: 11px;
      top : 4px;
      width: 25px;
      height: 25px;
    
    }
]]

return cfg