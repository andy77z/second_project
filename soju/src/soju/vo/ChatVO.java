package soju.vo;

public class ChatVO {
	private int chat_num;
	private String chat_time;
	private String chat_cont;
	private String mem_nick;
	private String art_name;
	private String photo;
	

	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getChat_num() {
		return chat_num;
	}
	public void setChat_num(int chat_num) {
		this.chat_num = chat_num;
	}
	public String getChat_time() {
		return chat_time;
	}
	public void setChat_time(String chat_time) {
		this.chat_time = chat_time;
	}
	public String getChat_cont() {
		return chat_cont;
	}
	public void setChat_cont(String chat_cont) {
		this.chat_cont = chat_cont;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getArt_name() {
		return art_name;
	}
	public void setArt_name(String art_name) {
		this.art_name = art_name;
	}
}
