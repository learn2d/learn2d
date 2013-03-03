// NPC by cmwelsh

NPC.extend({
  playerChat: function (chatMessage) {
    console.log('foo');
    console.log(chatMessage);
    if (this.player.chat === 'warp') {
      this.player.x = 30;
      this.player.y = 35;
    }
  }
});
