//LOCAL FILE
// C:\Users\Felipe\AppData\Roaming\MetaQuotes\Tester\FB9A56D617EDDDFE29EE54EBEFFE96C1\Agent-127.0.0.1-3000\MQL5\Files

int filehandle;
int count;

input int candle_size = 1000;
input string type_tick ="ask" ;

double volume_tick;
double open_tick;
double high_tick;
double low_tick;
double close_tick;

double tick_anterior;


double tyck;

int OnInit()

{
   ResetLastError();
   
   // NAME FILE
   filehandle=FileOpen(candle_size+"_candle_win$n_"+type_tick+".csv",FILE_WRITE|FILE_CSV);
   
   if(filehandle!=INVALID_HANDLE)
     {      
      Print("File opened correctly");
      FileWrite(filehandle,"timestamp open high low close");
     }
     
   else Print("Error in opening file,",GetLastError());
   
   PrintFormat("Caminho para do arquivo: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH)); 
   
   return(INIT_SUCCEEDED);   
}
    
void OnTick()
{

   MqlTick last_tick;
   
   if(SymbolInfoTick(Symbol(),last_tick))
   
      {
      
      count += 1;
      
      if(type_tick == "bid")
        {
          tyck = last_tick.bid;
        }
        
      if(type_tick == "ask")
        {
          tyck = last_tick.ask;
        }
      
     
      // OPEN
      if(count == 1)
        {
         open_tick = tyck;
        }
        
      // HIGH
      if(tyck >= tick_anterior)
        {
         high_tick = tyck;
        }

      // LOW
      if(tyck <= tick_anterior)
        {
         low_tick = tyck;
        }      
      
      // CLOSE
      if(count == candle_size)
        {
         close_tick = tyck;
         FileWrite(filehandle,last_tick.time,open_tick,high_tick,low_tick,close_tick);
         count = 0;
         volume_tick = 0;
        }
      
      tick_anterior = tyck;   
      
     }
     
   else Print("SymbolInfoTick() failed, error = ",GetLastError());
}
  
void OnDeinit(const int reason)
{

 FileClose(filehandle);
 
}
   
