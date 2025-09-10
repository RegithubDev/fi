package com.resustainability.reisp.dto.commons;

import java.util.List;

public class Pager<T> {
    private List<T> content;
    private boolean first;
    private boolean last;
    private boolean empty;
    private boolean sorted;
    private long totalElements;
    private long totalPages;
    private long size;
    private long page;
    private long numberOfElements;

    public Pager() {}
    public Pager(List<T> content, long total, int page, int size, boolean sorted) {
        this.content = content;
        this.totalElements = total;
        this.size = size;
        this.page = page;
        this.totalPages = (long) Math.ceil((double) total / size);
        this.numberOfElements = content.size();
        this.first = page == 0;
        this.last = page + 1 >= totalPages;
        this.empty = content.isEmpty();
        this.sorted = sorted;
    }

    public List<T> getContent() {
        return content;
    }

    public void setContent(List<T> content) {
        this.content = content;
    }

    public boolean isFirst() {
        return first;
    }

    public void setFirst(boolean first) {
        this.first = first;
    }

    public boolean isLast() {
        return last;
    }

    public void setLast(boolean last) {
        this.last = last;
    }

    public boolean isEmpty() {
        return empty;
    }

    public void setEmpty(boolean empty) {
        this.empty = empty;
    }

    public boolean isSorted() {
        return sorted;
    }

    public void setSorted(boolean sorted) {
        this.sorted = sorted;
    }

    public long getTotalElements() {
        return totalElements;
    }

    public void setTotalElements(long totalElements) {
        this.totalElements = totalElements;
    }

    public long getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(long totalPages) {
        this.totalPages = totalPages;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public long getPage() {
        return page;
    }

    public void setPage(long page) {
        this.page = page;
    }

    public long getNumberOfElements() {
        return numberOfElements;
    }

    public void setNumberOfElements(long numberOfElements) {
        this.numberOfElements = numberOfElements;
    }
}
