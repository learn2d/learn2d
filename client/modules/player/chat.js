// NPC by cmwelsh

//#CLIENTSIDE

this.onPlayerChats = function (message) {
  console.log('player chat:');
  console.log(message);
  this.player.set('public.chat', message);
  if (message === 'warp') {
    this.player.x = 100;
    this.player.y = 150;
  }
};
