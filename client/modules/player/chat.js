// NPC by cmwelsh

//#CLIENTSIDE

this.onPlayerChats = function (message) {
  console.log(message);
  if (message === 'warp') {
    this.player.x = 100;
    this.player.y = 150;
  }
}
